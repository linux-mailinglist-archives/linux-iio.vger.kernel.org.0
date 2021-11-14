Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFF44F906
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhKNQfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKNQfQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:35:16 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6378A604D7;
        Sun, 14 Nov 2021 16:32:19 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:37:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 09/10] iio: imu: add BNO055 serdev driver
Message-ID: <20211114163705.14f5efb6@jic23-huawei>
In-Reply-To: <CAN8YU5MNwVC0wLERN+PiK0GvEpoirA2Bpipk2UCT2-+05bi1_Q@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-10-andrea.merello@gmail.com>
        <20211028133134.5feed60b@jic23-huawei>
        <CAN8YU5MNwVC0wLERN+PiK0GvEpoirA2Bpipk2UCT2-+05bi1_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 16:33:44 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > > +static int bno055_sl_receive_buf(struct serdev_device *serdev,
> > > +                              const unsigned char *buf, size_t size)
> > > +{
> > > +     int status;
> > > +     struct bno055_sl_priv *priv = serdev_device_get_drvdata(serdev);
> > > +     int _size = size;  
> >
> > Why the local variable?  
> 
> size variable gets modified, so we cache the value to return in case of success.

Ah - missed that as unusual way around.  I'd modify the local variable instead
and perhaps call it something like remaining to reflect how it is being used?

> 
> > > +
> > > +     if (size == 0)
> > > +             return 0;
> > > +
> > > +     dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
> > > +     switch (priv->rx.state) {
> > > +     case RX_IDLE:
> > > +             /*
> > > +              * New packet.
> > > +              * Check for its 1st byte, that identifies the pkt type.
> > > +              */
> > > +             if (buf[0] != 0xEE && buf[0] != 0xBB) {
> > > +                     dev_err(&priv->serdev->dev,
> > > +                             "Invalid packet start %x", buf[0]);
> > > +                     bno055_sl_handle_rx(priv, STATUS_CRIT);
> > > +                     break;
> > > +             }
> > > +             priv->rx.type = buf[0];
> > > +             priv->rx.state = RX_START;
> > > +             size--;
> > > +             buf++;
> > > +             priv->rx.databuf_count = 0;
> > > +             fallthrough;
> > > +
> > > +     case RX_START:
> > > +             /*
> > > +              * Packet RX in progress, we expect either 1-byte len or 1-byte
> > > +              * status depending by the packet type.
> > > +              */
> > > +             if (size == 0)
> > > +                     break;
> > > +
> > > +             if (priv->rx.type == 0xEE) {
> > > +                     if (size > 1) {
> > > +                             dev_err(&priv->serdev->dev, "EE pkt. Extra data received");
> > > +                             status = STATUS_CRIT;
> > > +
> > > +                     } else {
> > > +                             status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
> > > +                     }
> > > +                     bno055_sl_handle_rx(priv, status);
> > > +                     priv->rx.state = RX_IDLE;
> > > +                     break;
> > > +
> > > +             } else {
> > > +                     /*priv->rx.type == 0xBB */
> > > +                     priv->rx.state = RX_DATA;
> > > +                     priv->rx.expected_len = buf[0];
> > > +                     size--;
> > > +                     buf++;
> > > +             }
> > > +             fallthrough;
> > > +
> > > +     case RX_DATA:
> > > +             /* Header parsed; now receiving packet data payload */
> > > +             if (size == 0)
> > > +                     break;
> > > +
> > > +             if (priv->rx.databuf_count + size > priv->rx.expected_len) {
> > > +                     /*
> > > +                      * This is a inconsistency in serial protocol, we lost
> > > +                      * sync and we don't know how to handle further data
> > > +                      */
> > > +                     dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
> > > +                     bno055_sl_handle_rx(priv, STATUS_CRIT);
> > > +                     priv->rx.state = RX_IDLE;
> > > +                     break;
> > > +             }
> > > +
> > > +             mutex_lock(&priv->lock);
> > > +             /*
> > > +              * NULL e.g. when read cmd is stale or when no read cmd is
> > > +              * actually pending.
> > > +              */
> > > +             if (priv->response_buf &&
> > > +                 /*
> > > +                  * Snoop on the upper layer protocol stuff to make sure not
> > > +                  * to write to an invalid memory. Apart for this, let's the
> > > +                  * upper layer manage any inconsistency wrt expected data
> > > +                  * len (as long as the serial protocol is consistent wrt
> > > +                  * itself (i.e. response header is consistent with received
> > > +                  * response len.
> > > +                  */
> > > +                 (priv->rx.databuf_count + size <= priv->expected_data_len))
> > > +                     memcpy(priv->response_buf + priv->rx.databuf_count,
> > > +                            buf, size);
> > > +             mutex_unlock(&priv->lock);
> > > +
> > > +             priv->rx.databuf_count += size;
> > > +
> > > +             /*
> > > +              * Reached expected len advertised by the IMU for the current
> > > +              * packet. Pass it to the upper layer (for us it is just valid).
> > > +              */
> > > +             if (priv->rx.databuf_count == priv->rx.expected_len) {
> > > +                     bno055_sl_handle_rx(priv, STATUS_OK);
> > > +                     priv->rx.state = RX_IDLE;
> > > +             }
> > > +             break;
> > > +     }
> > > +
> > > +     return _size;
> > > +}


