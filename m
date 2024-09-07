Return-Path: <linux-iio+bounces-9276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBA970290
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2F51C2189E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E915C14E;
	Sat,  7 Sep 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gDtvx9jA"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDD15575B;
	Sat,  7 Sep 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717629; cv=none; b=Ffv++o9yRwxX6m+cflnsry5NzbdZXH81XWiYUOOdRx+IGD3nE5KzJVwRPeup6Y0ibCinheVlHbXOgki3MnZHTIlpnsgLZZ7+55mW9d/ffBXCvAl76dZOySWpaq8WhCJII6StAvTj7AsZqhFmJPaMBt0TxKfpA1yzUiiIeeRGBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717629; c=relaxed/simple;
	bh=s27k5mEy8VSUEgorKgZR16XXq3J5gswprF0OHfkaZts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yo4ve4TU8KXHydAzJdCyrjYbs5ZeisL8GPw1A5aui69UVNB4EHIW98+7StSHa32gvvd1Wph71AltwOkTTIxo87Zn+mmowaixjEFQoASjvtDqrlQy/jOPpWxinTgY9lt7vnMwZ9i+gIWC84OnWglpi3lokwqQ7MS5wcug2rFyrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gDtvx9jA; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mvqKs8Zr7lt0qmvqKsJ2Fc; Sat, 07 Sep 2024 15:51:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725717073;
	bh=hNavVn77VF0lTtMSxrk81smDP2O/T7hN077eeKQGcV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gDtvx9jApf+CYTLvtwgutidBZrrFxmNH+eiWJAOmz3Ju2pfIvkZsbwwx/sz0wulkp
	 5iLLdckTEVxw+eqp4IGLQIIU5HMUsylQohKsn5Jwc4ZKjJB7YzLaIpIbGzPKStO2xq
	 ANzskTB36HG3wGNilPejxmCnT2cxLOu79ux+5wrguzDow9t15nQ52VjgZDM9qk/RtH
	 JzNQZjLA6t2zKz+vek0UKPP1lLEXWqYL0HXoopWKwUCr9mgTNQhBuTsbWJe3Doz1Yt
	 F2Y/mWDX0VG+JtKmfC4sVAklADEoI95hr9FfkbT5V90gNfeTL3JZ66vrjnnxD++5RL
	 VqCkmVsvc5+fQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Sep 2024 15:51:13 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?iio:=20addac:=20ad74xxx:=20Constify=20struct=20?= =?UTF-8?q?iio=5Fchan=5Fspec=E2=80=8B?=
Date: Sat,  7 Sep 2024 15:51:07 +0200
Message-ID: <da291278e78b983ea2e657a25769f7d82ea2a6d0.1725717045.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'struct iio_chan_spec' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  35749	   5879	    384	  42012	   a41c	drivers/iio/addac/ad74115.o
  32242	   3297	    384	  35923	   8c53	drivers/iio/addac/ad74413r.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  39109	   2519	    384	  42012	   a41c	drivers/iio/addac/ad74115.o
  33842	   1697	    384	  35923	   8c53	drivers/iio/addac/ad74413r.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/iio/addac/ad74115.c  | 18 +++++++++---------
 drivers/iio/addac/ad74413r.c | 21 +++++++++++----------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index 12dc43d487b4..bdbdd67536ff 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -191,7 +191,7 @@ enum ad74115_gpio_mode {
 };
 
 struct ad74115_channels {
-	struct iio_chan_spec		*channels;
+	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
 };
 
@@ -1295,46 +1295,46 @@ static const struct iio_info ad74115_info = {
 	_AD74115_ADC_CHANNEL(_type, index, BIT(IIO_CHAN_INFO_SCALE)	\
 					   | BIT(IIO_CHAN_INFO_OFFSET))
 
-static struct iio_chan_spec ad74115_voltage_input_channels[] = {
+static const struct iio_chan_spec ad74115_voltage_input_channels[] = {
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_voltage_output_channels[] = {
+static const struct iio_chan_spec ad74115_voltage_output_channels[] = {
 	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_MAIN),
 	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_current_input_channels[] = {
+static const struct iio_chan_spec ad74115_current_input_channels[] = {
 	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_current_output_channels[] = {
+static const struct iio_chan_spec ad74115_current_output_channels[] = {
 	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_2_wire_resistance_input_channels[] = {
+static const struct iio_chan_spec ad74115_2_wire_resistance_input_channels[] = {
 	_AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1,
 			     BIT(IIO_CHAN_INFO_PROCESSED)),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_3_4_wire_resistance_input_channels[] = {
+static const struct iio_chan_spec ad74115_3_4_wire_resistance_input_channels[] = {
 	AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_digital_input_logic_channels[] = {
+static const struct iio_chan_spec ad74115_digital_input_logic_channels[] = {
 	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
 };
 
-static struct iio_chan_spec ad74115_digital_input_loop_channels[] = {
+static const struct iio_chan_spec ad74115_digital_input_loop_channels[] = {
 	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
 	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
 	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 2410d72da49b..1e2f6d9804e3 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -45,8 +45,8 @@ struct ad74413r_channel_config {
 };
 
 struct ad74413r_channels {
-	struct iio_chan_spec	*channels;
-	unsigned int		num_channels;
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
 };
 
 struct ad74413r_state {
@@ -1138,34 +1138,34 @@ static const struct iio_info ad74413r_info = {
 	AD74413R_ADC_CHANNEL(IIO_CURRENT,  BIT(IIO_CHAN_INFO_SCALE)	\
 			     | BIT(IIO_CHAN_INFO_OFFSET))
 
-static struct iio_chan_spec ad74413r_voltage_output_channels[] = {
+static const struct iio_chan_spec ad74413r_voltage_output_channels[] = {
 	AD74413R_DAC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)),
 	AD74413R_ADC_CURRENT_CHANNEL,
 };
 
-static struct iio_chan_spec ad74413r_current_output_channels[] = {
+static const struct iio_chan_spec ad74413r_current_output_channels[] = {
 	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
 	AD74413R_ADC_VOLTAGE_CHANNEL,
 };
 
-static struct iio_chan_spec ad74413r_voltage_input_channels[] = {
+static const struct iio_chan_spec ad74413r_voltage_input_channels[] = {
 	AD74413R_ADC_VOLTAGE_CHANNEL,
 };
 
-static struct iio_chan_spec ad74413r_current_input_channels[] = {
+static const struct iio_chan_spec ad74413r_current_input_channels[] = {
 	AD74413R_ADC_CURRENT_CHANNEL,
 };
 
-static struct iio_chan_spec ad74413r_current_input_loop_channels[] = {
+static const struct iio_chan_spec ad74413r_current_input_loop_channels[] = {
 	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
 	AD74413R_ADC_CURRENT_CHANNEL,
 };
 
-static struct iio_chan_spec ad74413r_resistance_input_channels[] = {
+static const struct iio_chan_spec ad74413r_resistance_input_channels[] = {
 	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
 };
 
-static struct iio_chan_spec ad74413r_digital_input_channels[] = {
+static const struct iio_chan_spec ad74413r_digital_input_channels[] = {
 	AD74413R_ADC_VOLTAGE_CHANNEL,
 };
 
@@ -1270,7 +1270,8 @@ static int ad74413r_setup_channels(struct iio_dev *indio_dev)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
 	struct ad74413r_channel_config *config;
-	struct iio_chan_spec *channels, *chans;
+	const struct iio_chan_spec *chans;
+	struct iio_chan_spec *channels;
 	unsigned int i, num_chans, chan_i;
 	int ret;
 
-- 
2.46.0


