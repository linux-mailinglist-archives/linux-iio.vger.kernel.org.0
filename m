Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67849301CA7
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAXOV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 24 Jan 2021 09:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbhAXOVW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 09:21:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E616D22D6E;
        Sun, 24 Jan 2021 14:20:39 +0000 (UTC)
Date:   Sun, 24 Jan 2021 14:20:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 0/4] Fix/Improve sync clock mode handling
Message-ID: <20210124142036.44f7d58f@archlinux>
In-Reply-To: <20210121114954.64156-1-nuno.sa@analog.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 12:49:50 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> The first patch in this series is just a simple helper to lock/unlock
> the device. Having these helpers make the code slightly neater (IMHO).
> 
> The following patches introduces changes in the sampling frequency
> calculation when sync scale/pps modes are used. First, it's important
> to understand the purpose of this mode and how it should be used. Let's
> say our part has an internal rate of 4250 (e.g adis1649x family) and the
> user wants an output rate of 200SPS. Obviously, we can't use this
> sampling rate and divide back down to get 200 SPS with decimation on.
> Hence, we can use this mode to give an input clock of 1HZ, scale it to
> something like 4200 or 4000 SPS and then use the decimation filter to get
> the exact desired 200SPS. There are also some limits that should be
> taken into account when scaling:
> 
>  * For the devices in the adis16475 driver:
>      - Input sync frequency range is 1 to 128 Hz
>      - Native sample rate: 2 kSPS.  Optimal range: 1900-2100 sps
> 
>  * For the adis1649x family (adis16480 driver):
>     - Input sync frequency range is 1 to 128 Hz
>     - Native sample rate: 4.25 kSPS.  Optimal range: 4000-4250 sps 
> 
> I'm not 100% convinced on how to handle the optimal minimum. For now,
> I'm just throwing a warning saying we might get into trouble if we get a
> value lower than that. I was also tempted to just return -EINVAL or
> clamp the value. However, I know that there are ADI customers that
> (for some reason) are using a sampling rate lower than the minimum
> advised.

So the opening question I'd have here is how critical is the actual
userspace sampling rate to your users?   Often they don't mind
getting a little more data than they asked for (say 200.5Hz when asking
for 200) and can always read back the attribute after writing it to
discover this has happened. 

As such, once you've discovered that value doesn't have an exact
match, perhaps tweak the output data rate until it fits nicely?
A bit of quick investigation suggests (by my wife who happened
to be sat across the room) suggests that you have a hideous set
of local minima so your best bet is to brute force search
(not that bad and we don't expect to change this a lot!)

> 
> That said, the patch for the adis16480 driver is a fix as this mode was
> being wrongly handled. There should not be a "separation" between using
> the sync_scale and the dec_rate registers. The way things were being done,
> we could easily get into a situation where the part could be running with
> an internal rate way lower than the optimal minimum.
> 
> For the adis16475 drivers, things were not really wrong. They were just
> not optimal as we were forcing users to specify the IMU scaled internal
> rate once in the devicetree. Calculating things at runtime gives much
> more flexibility to choose the output rate.
> 
> Nuno Sá (4):
>   iio: adis: add helpers for locking
>   iio: adis16480: fix pps mode sampling frequency math
>   iio: adis16475: improve sync scale mode handling
>   dt-bindings: adis16475: remove property
> 
>  .../bindings/iio/imu/adi,adis16475.yaml       |   9 --
>  drivers/iio/imu/adis16475.c                   | 110 ++++++++++++----
>  drivers/iio/imu/adis16480.c                   | 120 +++++++++++++-----
>  include/linux/iio/imu/adis.h                  |  10 ++
>  4 files changed, 178 insertions(+), 71 deletions(-)
> 

