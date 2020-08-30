Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36739256D69
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgH3LL6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 07:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgH3LLv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 07:11:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2C020757;
        Sun, 30 Aug 2020 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598785911;
        bh=49OJIxyOPMZUAp+93Ub60KpOyCCqoNiyoBmC+jSKGMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=amkiRBqW8qjh46XHvFi6rlDLa7tg9uLDdr6j1mD92ycc2nbzDUUZmPlp5TvSirbtu
         k6OO28fPdK9AIouRf3k23mZTwfn8JRuJXKKb+btoMlP/MddpwiKCEwCgA6RinqJrXP
         4+VuQUrMtK964rwXA1oSeBCIoLg7RrQm2llbnhCU=
Date:   Sun, 30 Aug 2020 12:11:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform: cros_ec: Reduce ligthbar get version
 command
Message-ID: <20200830121147.6920e1ee@archlinux>
In-Reply-To: <CAPUE2uu7wQvJtesgk1sw=b7AOj7-7RW3skcvHs9y2kL_k7-tdA@mail.gmail.com>
References: <20200826002945.394562-1-gwendal@chromium.org>
        <20200829165433.57b0e5e4@archlinux>
        <CAPUE2uu7wQvJtesgk1sw=b7AOj7-7RW3skcvHs9y2kL_k7-tdA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Aug 2020 00:00:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sat, Aug 29, 2020 at 8:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 25 Aug 2020 17:29:45 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  
> > > By default, the lightbar commands are set to the
> > > biggest lightbar command and response. That length is greater than 128
> > > bytes and may not work on all machines.
> > > But all EC are probed for lightbar by sending a get version request.
> > > Set that request size precisely.
> > >
> > > Before the command would be:
> > > cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
> > > Afer:
> > > cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> > Hi Gwendal,
> >
> > Description seems to me to suggest this is a fix?
> > Are there known machines on which it doesn't work currently?  
> We have a prototype [without lightbar] where the command size was
> limited to 128 bytes.
> Given we issue a get_lightbar_version on all chromebooks, we had a
> failure on this prototype. Devices with a lightbar must support a
> command size greater or equal to 194 bytes.
> Beside helping the prototype to boot, this patch slightly speeds up
> the enumeration of devices managed by the EC.
> >
> > If so, please can I have a fixes tag.  If it's just a precaution
> > against future problems then let me know and I can add it for the
> > next merge window.  
> Done in v3.
> Note I made a mistake by sending the patch to linux-iio as it targeted
> platform/chromeos.

I hadn't even noticed that it wasn't in IIO. Oops :)

Jonathan
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > > Changes since v1:
> > > - Remove BUG and TEST fields.
> > >
> > >  drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> > > index b59180bff5a3e..ef61298c30bdd 100644
> > > --- a/drivers/platform/chrome/cros_ec_lightbar.c
> > > +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> > > @@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
> > >
> > >       param = (struct ec_params_lightbar *)msg->data;
> > >       param->cmd = LIGHTBAR_CMD_VERSION;
> > > +     msg->outsize = sizeof(param->cmd);
> > > +     msg->result = sizeof(resp->version);
> > >       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> > >       if (ret < 0) {
> > >               ret = 0;  
> >  

