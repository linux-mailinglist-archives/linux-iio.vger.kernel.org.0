Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1339C80
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFHKwO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 06:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfFHKwN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 06:52:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429C92146E;
        Sat,  8 Jun 2019 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559991132;
        bh=kV46yONNbVuFQFsT+giJeL1QokbE/1eKyFDNw+3LHiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y1YwB0TXeqd5hJSYiQ6zC3kS+Fl5VQmIUx7CUBQpf+O6kAOPiZsbKyqwkurdSXByE
         SLoexhcmM9ANbe+SdH8IbCSzgpR+FuoWQkJgGZzdi/1+yWzzobJ70vwN1+kZ6Klcok
         xO6dCD6OGBOdSAp2oLtqpthh0b4G8LLsPcsmpjCo=
Date:   Sat, 8 Jun 2019 11:52:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-iio <linux-iio@vger.kernel.org>, kernel@pyra-handheld.com,
        lkml <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Bastien Nocera <hadess@hadess.net>
Subject: Re: [Letux-kernel] [RFC v2] iio: input-bridge: optionally bridge
 iio acceleometers to create a /dev/input interface
Message-ID: <20190608115207.22a6fa9a@archlinux>
In-Reply-To: <CCD87A8D-FF65-4681-964B-22870716D655@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
        <20190407133037.0ad98897@archlinux>
        <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
        <20190414124029.1f1f6084@archlinux>
        <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
        <20190422152014.7c6637ab@archlinux>
        <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
        <D4F87479-4FF7-4DBC-81D5-1BA836D2C889@goldelico.com>
        <20190511120536.647c8676@archlinux>
        <CCD87A8D-FF65-4681-964B-22870716D655@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Jun 2019 09:30:40 +0200
H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Hi Jonathan,
> sorry again for the long delay. I just now found a little time to summarize and try to
> get the discussion boiled down to the key difference.
> 
> > Am 11.05.2019 um 13:05 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > On Thu, 9 May 2019 19:02:49 +0200
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >> 
> >> If you close the lid, the display is turned upside down and y and z axes reverse sign.
> >> 
> >> So there remains only the issue that user-space must know which sensor device file is which sensor
> >> and can do the calculation of the lid angle. This is possible because the iio accelerometer name
> >> is available through the input event ioctls.
> >> 
> >> In summary this case also does not need policy or configuration. Just user space using the information
> >> that is already presented.  
> > 
> > I disagree with that last statement.  If there is a lid angle sensor, policy is
> > needed to know which of your associated orientation is the base one and which
> > device indicates the lid angle.  
> 
> > 
> > Actually most of the time what you will do is pick one 'correct' sensor under
> > some configuration of the device and use that.  That is policy.  Yes, you could
> > bake the policy in to device tree, but then you can also bake in the association
> > between the underlying IIO sensor and any virtual input sensor.  
> 
> Ah, maybe I did not understand what you mean by policy here.
> 
> Indeed, choosing the right sensor is always something which is application specific
> and something user-space must obviously dictate. And we agree this should *not* be
> in device tree (or user-space scanning device tree) because that describes hardware
> and not user-space interaction.
> 
> But I still do not think that this requires a new mechanism where user-space
> *tells* the kernel which sensor to use and present as which device.
> 
> Equally well, the kernel can present all sensors it knows about and a set of properties
> that allow the user-space to simply choose the right one ("apply policy"). Properties
> could be file name (e.g. provided by udev), device name, label (provided by DT) or similar.
> 
> If it were absolutely necessary to tell the kernel to map iio devices to something before
> use, I think Bastien would not have been able to implement his library. He also has to
> choose the right sensors. This seems to work and not need a new mechanism.
> 
> > 
> > Anyhow, we still disagree on whether any such virtual input interface
> > should be a userspace policy decision.  So far I haven't seen any compelling
> > argument why it shouldn't be and the flexibility such a policy based interface
> > provides is its major advantage.  
> 
> I still think it is not needed because kernel already provides necessary information
> to user-space to make policy decisions (by ignore unwanted interfaces) without needing
> a new interface where the user-space tells the kernel to activate some interfaces.
> 
> So the key difference is about the question if user-space needs to tell the kernel first
> that it wants to see a specific interface or just makes use of it if present.

Absolutely. Good summary, but I don't think either of us is going
to persuade the other.

I've started work on my proposal but things have been 'interesting' in the
last few weeks so it may be a little while yet before I have anything
to share.

Jonathan

> 
> BR and thanks,
> Nikolaus
> 

