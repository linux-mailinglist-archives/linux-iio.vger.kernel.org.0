Return-Path: <linux-iio+bounces-24084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E2B56241
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0341A7AC9B5
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA42EE5F5;
	Sat, 13 Sep 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="MjhXIRAa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6E944F;
	Sat, 13 Sep 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757781166; cv=none; b=r3h08NCuDTNXhXoaR2P4TWShnzdhoOeKu9V12VXBQmtIQVSaxf4I7XOkt/mDUdRTpCanpIr/elFV8kMLjrBDGWJnxR5zs0klDlslsBHIz/rWLlrw17xzV9Uxf3K3B0nl4VRqCE8z8+2K+2Y6kCjD74ZXtaTrDJSj0oRgw+8ZkdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757781166; c=relaxed/simple;
	bh=TClIczkA1dqCneaeajy+7psQhihdDWrymDzBA3Qm99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVqSujeUnsMetjnhQJAM0w87Phv2VfFxq94NwVCNGB6EOZP9ZYScq+Lrm/KKQEtu1KpYg1hRmbVmM96N06dtuEaBHHDObq7AQpFSdRoNPU6LiGg5KI33WpS1dWl9+I2mtA8zdzRhbPWL0jIFi6mosKpydQuVPMqt44BsggSbFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=MjhXIRAa; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id ED9D2173BE2;
	Sat, 13 Sep 2025 19:32:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757781162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnW7pB3M4rqQbhC3HFPiYkMusXa21KSoLOZlD3AhDXg=;
	b=MjhXIRAaGuMZPdrgr0mzKoJFAGc/eBoatd8G5wTDPFa7LTJhVTMq04EUm2TT6F1m9TXfEE
	Yq+ViCBSxV/iTnYpqIbA5JqKCywNYYn4wYu9Py7vT2t68zgfLNH3204VXBcvEwDHcQS7r/
	Ol4jPHYJKqgpi2Qc6ZA7nPg+55nsjsphw8mg0O4tdWXYxa4E8XqBnO1zPSuSgL0/s0WObZ
	OS6hfEsRkgG5Z41i4vK1/Z0cQmt24tzxuv9F5WkDI0TGgXL14LbWs0dQEuFRfFM75KVRCn
	eWLAp36PkYLGTohN2HcBnz+ASdnfPtkWrMEXXov6cjFBCfjJgJH9tOOvJbNH1A==
Date: Sat, 13 Sep 2025 19:32:39 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
Message-ID: <aMWcpxacC30ME9Ew@sunspire>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>

On Sat, Sep 13, 2025 at 06:39:36PM +0300, Petre Rodan wrote:
> +static irqreturn_t bma220_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int rv;
> +	unsigned int bma220_reg_if1;
> +
> +	guard(mutex)(&data->lock);
> +	rv = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
> +	if (rv)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}

sorry, errant '{' in FIELD_GET line throws compilation off, will fix in next rev.

best regards,
peter

