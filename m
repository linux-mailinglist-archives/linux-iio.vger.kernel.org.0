Return-Path: <linux-iio+bounces-9999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FAD98CDD8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE57B21D7F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10402D517;
	Wed,  2 Oct 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yk6OBkWe"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136D19415D;
	Wed,  2 Oct 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854675; cv=none; b=XObhGUMDtLhVAw033MRDf0aRGzt5IvdINJFq25wfc2krI9bVmeVEoiRX1O7PhS/TanbOGDZ1nG4tqcudLHEteSX3/kk0j+16szSItBbpNqk6ugGY1pofjzH6PELseVFbEhTKq8Hvgde/qkPlvFvRh08/IQgJm1csq1mjBfTUrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854675; c=relaxed/simple;
	bh=kD3TcB8p61Rvu41vL3zPUxYZaz2PHQZzGTTGLec5DfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgpkUJX8GKPt9WHCOwuhw3+MKf5eyI7NJGXEaqkq1axJIS1X5U6ILQ8ScU1ulpE6SvCzYnoyS9+kz/tQxUABy+PXiUKR8fAtYGWWJGXtILWQ+fLW/vcaeuu2Mu8pXAEuZGYsk213uy4xAlt+MQTR5sYMJ2TTr92aRDup2qwA2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yk6OBkWe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA1156000B;
	Wed,  2 Oct 2024 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727854671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ch8neMD+aNUfSUIjEArMj3n/v/qHmDEP0c/+zebMDXg=;
	b=Yk6OBkWeJ9U3FIFCRXUebyI6KvSnvGjT/qbzCEGgZJpM70xp02Y97SJVS1zZFfBjmjk2l8
	BaJ6sFH/poJhTiJuITn5tPW2zH7MnTv0O6CxI763WUMnzUZbQB88QUDC2ZHGvwbKHD6mVK
	iZLzln21qev9Gb6FRu0/Qu/06jkmCgunnUiBHIkSsEUY8z/aGq/wOMDDT4nKRb9z7mIOiU
	U0XKT0Vm2oKxJCjKIN+W/JX3HUPnLRFRtpbf+EKlacGkImdb6Ch+xScdBqdGk7Ra3UWVMf
	h12bojLliggGYlBwdj5zpzpbO2npZv4axhcZwfDUdzQSwzvju4krT2T0QgsRKw==
Date: Wed, 2 Oct 2024 09:37:49 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Message-ID: <20241002093749.17f6f239@bootlin.com>
In-Reply-To: <CAMknhBHRY=MKmpiMnwHk8Gpdi5pWaUOZosyKTzX=83DuAxBvOA@mail.gmail.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-4-herve.codina@bootlin.com>
	<CAMknhBHRY=MKmpiMnwHk8Gpdi5pWaUOZosyKTzX=83DuAxBvOA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi David,

On Tue, 1 Oct 2024 12:19:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Oct 1, 2024 at 2:47 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> > (voltage and current), 16-Bit ADC with an I2C Interface.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---  
> 
> ...
> 
> > +static int pmc_adc_read_raw_ch(struct pmc_adc *pmc_adc, u8 cmd, int *val)
> > +{
> > +       s32 ret;
> > +
> > +       ret = i2c_smbus_read_word_swapped(pmc_adc->client, cmd);
> > +       if (ret < 0) {
> > +               dev_err(&pmc_adc->client->dev, "i2c read word failed (%d)\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       *val = sign_extend32(ret, 16);  
> 
> Shouldn't this be 15, not 16?

Yes, indeed, I double checked on my side and it should be 15!
Thanks for catching it. It will be fixed in the next iteration.

> 
> > +       return 0;
> > +}
> > +  
> 
> ...
> 
> > +
> > +static int pmc_adc_probe(struct i2c_client *client)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct pmc_adc *pmc_adc;
> > +       struct clk *clk;
> > +       s32 val;
> > +       int ret;
> > +
> > +       ret = devm_regulator_bulk_get_enable(&client->dev, ARRAY_SIZE(pmc_adc_regulator_names),
> > +                                            pmc_adc_regulator_names);
> > +       if (ret)
> > +               return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
> > +
> > +       clk = devm_clk_get_optional_enabled(&client->dev, "osc");
> > +       if (IS_ERR(clk))
> > +               return dev_err_probe(&client->dev, PTR_ERR(clk), "Failed to get osc clock\n");
> > +
> > +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*pmc_adc));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       pmc_adc = iio_priv(indio_dev);
> > +       pmc_adc->client = client;
> > +
> > +       val = i2c_smbus_read_byte_data(pmc_adc->client, PMC_ADC_CMD_REQUEST_PROTOCOL_VERSION);
> > +       if (val < 0)
> > +               return dev_err_probe(&client->dev, val, "Failed to get protocol version\n");
> > +
> > +       if (val != 0x01) {
> > +               dev_err(&client->dev, "Unsupported protocol version 0x%02x\n", val);  
> 
> Use dev_err_probe?

Yes, will be changed in the next iteration.

> 
> > +               return -EINVAL;
> > +       }
> > +

Best regards,
Hervé

