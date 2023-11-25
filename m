Return-Path: <linux-iio+bounces-346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85B7F8C01
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5671F20F2D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C628E27;
	Sat, 25 Nov 2023 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEDX8mPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3828E0A;
	Sat, 25 Nov 2023 15:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A854C433C8;
	Sat, 25 Nov 2023 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700925607;
	bh=1pvnCX5R8u7RfMiNPMMmS+WyuEpdLzjE3FRiy8NZtag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HEDX8mPbSBds2f9EPZIoR4PeAeVug9LqWOLy4sEKt1ZLgpSQ81ClVczXPJH7ok8/n
	 xlur70r2f2X8KOkin4mEpIGOWbCVYwxPglQUXK0793tK0lQNkt/TWAR643uOgymRDX
	 JMnau9dxkkRPbnvWXrwGoQY7I/743LfrKMY1TJgFd0vMNHrU3rD1PbPi8/+EbL10WE
	 s6P2+EOTMsuInMFG26T/EUwZtaEHItecdAjYRs9rGA1Wr4tLSAhndiPXYTo+g+Jp7q
	 3eDaoTl7tce+RxUhSK1CgLxBWFl9QQ4nnFqOtgKR/QHoBGlS7+sn8rIccdMAnxdp/R
	 YBM8wLekOBbwg==
Date: Sat, 25 Nov 2023 15:19:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: frequency: admfm2000: New driver
Message-ID: <20231125151959.00261229@jic23-huawei>
In-Reply-To: <CAKv63uvod-zdYSy93sJPBefBrqUUGhKDRLrC3vxvdeTZ4eM-nA@mail.gmail.com>
References: <20231123094357.222371-1-kimseer.paller@analog.com>
	<20231123094357.222371-2-kimseer.paller@analog.com>
	<CAKv63uvod-zdYSy93sJPBefBrqUUGhKDRLrC3vxvdeTZ4eM-nA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 11:19:51 +0100
Crt Mori <cmo@melexis.com> wrote:

> Hi,
> Just minor remark inline.
> 
> Best regards,
> Crt

Hi Crt,

Please crop replies / reviews to only relevant context. If there are lots of
comments it maybe fine to leave whole driver but that's not the case ehre.

Should only see something like...

Thanks,

Jonathan

> 
> On Thu, 23 Nov 2023 at 10:44, Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >
> > Dual microwave down converter module with input RF and LO frequency
> > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > for each down conversion path.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
...


> > +static int admfm2000_setup(struct admfm2000_state *st,
> > +                          struct iio_dev *indio_dev)
> > +{

...

> > +       if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
> > +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> > +                             ADMF20000_DSA_GPIOS);  
> 
> no return -ENODEV here?
> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int admfm2000_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct iio_dev *indio_dev;
> > +       struct admfm2000_state *st;
> > +       int ret;  
> 
> Order these in reverse christmass tree like you did above.
> 
> 
> > +
> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st = iio_priv(indio_dev);
> > +
> > +       indio_dev->name = "admfm2000";
> > +       indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
> > +       indio_dev->channels = admfm2000_channels;
> > +       indio_dev->info = &admfm2000_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +       st->gain[0] = ADMF20000_DEFAULT_GAIN;
> > +       st->gain[1] = ADMF20000_DEFAULT_GAIN;
> > +
> > +       mutex_init(&st->lock);
> > +
> > +       ret = admfm2000_setup(st, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = admfm2000_channel_config(st, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}

Thanks,

Jonathan

