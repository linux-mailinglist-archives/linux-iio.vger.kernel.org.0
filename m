Return-Path: <linux-iio+bounces-20448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3FAD5A5F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292DB1E0430
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F61AF0CE;
	Wed, 11 Jun 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opoaqt25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275011632D7;
	Wed, 11 Jun 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655521; cv=none; b=nLQL+ry1mp5cGkTHdUzH0KEl40mf5k6LCpFQGlJ5fvWL+QR7rIXT42d030dYuWobElDsPfDRKsFIYnL7oEQblOjf67o6/dcOSRSHlPJRMjuNWdJXGVl3CwEwWlL8LesP3oOPWT6WrBy2vmot41lK5CP2d3RCHMMCWNASA7MNaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655521; c=relaxed/simple;
	bh=IzxKk/Q/rHFtELufmehQFw1qSKOWCXL50Kire+AoROo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhG1CUjj2aRmTmGIFlRQjkv7V10MOm+EWxFCjgr8bm3F2UW4d3FyopAQYfueDtEnN5li1tPGsrM4ctGEw3TxsGCQESh/LbYTRGkWatZtr8pceNQ0Np4iiqIz2lwVCeBn6R6EERZsbKk9Tw7v1UMj8xyGDnyokuOVjDBoQtqIdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opoaqt25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BDAC4CEEA;
	Wed, 11 Jun 2025 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749655520;
	bh=IzxKk/Q/rHFtELufmehQFw1qSKOWCXL50Kire+AoROo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opoaqt25Ud+nc8M0XmqGGcIvv2RL49TLbsut/GXV3oPsfG7msmMgEHqCc5VMDsDXL
	 662GVyR78xUmiupTlAah11eTbOlaY3Q3Ax5Nl2PAxAY2ntybsJet/ry/Q4RFkQ72x3
	 u/AaUSSbE2Nm/PStE9kwj+7b9VtfqrOVq9gRKoTpXjV9LQLUlUgXkJmMDAceABq7D0
	 SVZayDKYZu39mwY1z7c8nz07mS5Zc9p7d7JTSFU3jHD3/XojW+sdN9untcgSkMzSjH
	 z/MSmG6NDF7kaJoiWhJqXm+rHB2AJTtJY7eiqomWnmteoChyMImjteUxA98fWQN1A4
	 XRgZ4QYXvGyKA==
Date: Wed, 11 Jun 2025 16:25:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>, "Miclaus, Antoniu"
 <Antoniu.Miclaus@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, adureghello <adureghello@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, "Schmitt, Marcelo"
 <Marcelo.Schmitt@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, "Nechita, Ramona"
 <Ramona.Nechita@analog.com>, Herve Codina <herve.codina@bootlin.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250611162507.6868c8c6@jic23-huawei>
In-Reply-To: <PH0PR03MB63351F2AA87604CC10BB6EC8D16AA@PH0PR03MB6335.namprd03.prod.outlook.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
	<20250605150948.3091827-6-pop.ioan-daniel@analog.com>
	<20250607164428.7a245af5@jic23-huawei>
	<PH0PR03MB63351F2AA87604CC10BB6EC8D16AA@PH0PR03MB6335.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 12:09:22 +0000
"Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com> wrote:

> > 
> > Why do we need this .channel element if all instances use the same one?  If you
> > are are shortly going to add support for more devices where this will change
> > then this is ok.  If not, just have one static const channel and use that without
> > looking it up via these chip_info structures.
> >  
> 
> Hi! I'm not aware of any other parts that use different channel types. It's true that all parts use the same .channel.
> Should I submit a new patch version with the requested change?

No need - it's an easy tweak (hopefully).  I fixed up the owner thing Nuno noticed
and applied this diff whilst picking this up.


diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
index 487d661f9050..9adf85a732ce 100644
--- a/drivers/iio/adc/ad7405.c
+++ b/drivers/iio/adc/ad7405.c
@@ -25,7 +25,6 @@ static const unsigned int ad7405_dec_rates_range[] = {
 
 struct ad7405_chip_info {
        const char *name;
-       struct iio_chan_spec channel;
        const unsigned int full_scale_mv;
 };
 
@@ -69,7 +68,7 @@ static int ad7405_read_raw(struct iio_dev *indio_dev,
        switch (info) {
        case IIO_CHAN_INFO_SCALE:
                *val = st->info->full_scale_mv;
-               *val2 = st->info->channel.scan_type.realbits - 1;
+               *val2 = indio_dev->channels[0].scan_type.realbits - 1;
                return IIO_VAL_FRACTIONAL_LOG2;
        case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
                *val = st->dec_rate;
@@ -78,7 +77,7 @@ static int ad7405_read_raw(struct iio_dev *indio_dev,
                *val = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st->dec_rate);
                return IIO_VAL_INT;
        case IIO_CHAN_INFO_OFFSET:
-               *val = -(1 << (st->info->channel.scan_type.realbits - 1));
+               *val = -(1 << (indio_dev->channels[0].scan_type.realbits - 1));
                return IIO_VAL_INT;
        default:
                return -EINVAL;
@@ -120,48 +119,44 @@ static const struct iio_info ad7405_iio_info = {
        .read_avail = &ad7405_read_avail,
 };
 
-#define AD7405_IIO_CHANNEL {                                   \
-       .type = IIO_VOLTAGE,                                    \
-       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
-                       BIT(IIO_CHAN_INFO_OFFSET),              \
-       .info_mask_shared_by_all = IIO_CHAN_INFO_SAMP_FREQ |    \
-                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
-       .info_mask_shared_by_all_available =                    \
-                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
-       .indexed = 1,                                           \
-       .channel = 0,                                           \
-       .channel2 = 1,                                          \
-       .differential = 1,                                      \
-       .scan_index = 0,                                        \
-       .scan_type = {                                          \
-               .sign = 'u',                                    \
-               .realbits = 16,                                 \
-               .storagebits = 16,                              \
-       },                                                      \
-}
+static const struct iio_chan_spec ad7405_channel = {
+       .type = IIO_VOLTAGE,
+       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+                       BIT(IIO_CHAN_INFO_OFFSET),
+       .info_mask_shared_by_all = IIO_CHAN_INFO_SAMP_FREQ |
+                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+       .info_mask_shared_by_all_available =
+                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+       .indexed = 1,
+       .channel = 0,
+       .channel2 = 1,
+       .differential = 1,
+       .scan_index = 0,
+       .scan_type = {
+               .sign = 'u',
+               .realbits = 16,
+               .storagebits = 16,
+       },
+};
 
 static const struct ad7405_chip_info ad7405_chip_info = {
        .name = "ad7405",
        .full_scale_mv = 320,
-       .channel = AD7405_IIO_CHANNEL,
 };
 
 static const struct ad7405_chip_info adum7701_chip_info = {
        .name = "adum7701",
        .full_scale_mv = 320,
-       .channel = AD7405_IIO_CHANNEL,
 };
 
 static const struct ad7405_chip_info adum7702_chip_info = {
        .name = "adum7702",
        .full_scale_mv = 64,
-       .channel = AD7405_IIO_CHANNEL,
 };
 
 static const struct ad7405_chip_info adum7703_chip_info = {
        .name = "adum7703",
        .full_scale_mv = 320,
-       .channel = AD7405_IIO_CHANNEL,
 };
 
 static const char * const ad7405_power_supplies[] = {
@@ -200,7 +195,7 @@ static int ad7405_probe(struct platform_device *pdev)
                return -EINVAL;
 
        indio_dev->name = st->info->name;
-       indio_dev->channels = &st->info->channel;
+       indio_dev->channels = &ad7405_channel;
        indio_dev->num_channels = 1;
        indio_dev->info = &ad7405_iio_info;
 
Let me know if I messed it up.  Pushed out as testing for now.

Thanks,

Jonathan

