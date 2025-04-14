Return-Path: <linux-iio+bounces-18117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2253A88BB0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661C016DFB8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229221AF0D0;
	Mon, 14 Apr 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8IuGRn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97781A5BB1;
	Mon, 14 Apr 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656357; cv=none; b=XmlFM8oiHaLXLMQIb9rL9piCeSvYYfbFZjwD0xS3YgyvgOd8vvwZBoz2OB2B35Ey3JODb7Qdjs47ZaQInYRFVewhpi6XTp9+3/G16LzQR61yrAq9KSnJc7S6/hipugB+PGPmJ9EekaFVeVPnOnY8d7Q39aAwtCN/HXdOMrwneNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656357; c=relaxed/simple;
	bh=Q+ArbtoUYHF9rW7RmtIkv3LRhYSlJIYQ+VVn8GGi6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGaIrkD5mCgsW++E1LuBRWbAEg5EmRDp0vHTUymRHhpigzxdCIAHs/1XRqWZSLOx2ySo4B5WLl5FPnjbsc9vbyHpkZoFr4aHGiGnY1GIMlANMORwPfuVgKvcPKmSHVusgtp2A/YmquxI0AjA02AfTJxqRxcOAoXrOp3SmBfyvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8IuGRn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A3AC4CEE5;
	Mon, 14 Apr 2025 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744656357;
	bh=Q+ArbtoUYHF9rW7RmtIkv3LRhYSlJIYQ+VVn8GGi6bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8IuGRn2FGs+y0ChWAs0HGqqeUM7B9v3Y1QIjDgHqkVOn6M1ZIETBr/bprujigXeF
	 xflvYJhpUmLXg5GZnGRb9vcc3Jzg6gvMY2npb7iASSHiUpQWO0jzQqdJPdEeJMYyj/
	 Ul7r/Q7pmXD/UPKt75c0myhmdxI+kTmNFtm2OqHK55pvqp0kNjEqdOf/Fp+cC9LAs5
	 VGUzgr9RyBa9fnWNoLDG6avcVExASmkbywescYFAvtrQx7n9MnjB5T4ggYafto/N5e
	 upW9nXGKW+XQnr3yaOq7Xw8wYIuGV8Fs/XECn/IbVTwi0A1ne7LiVDED6LBOv0r1bU
	 /RcHRMoskwVRA==
Date: Mon, 14 Apr 2025 19:45:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Message-ID: <20250414194549.4786338a@jic23-huawei>
In-Reply-To: <Z_zD0uvJn_Fz1SOF@smile.fi.intel.com>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
	<20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-2-19e4e2f8f7eb@tdk.com>
	<Z_zD0uvJn_Fz1SOF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 11:14:10 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Apr 10, 2025 at 05:39:41PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > Use generic fwnode_irq_get_byname() for getting interrupt pin using
> > interrupt name. Only INT1 is supported by the driver currently.
> > 
> > If not found fallback to first defined interrupt to keep compatibility.  
> 
> ...
> 
> > -	return inv_icm42600_core_probe(regmap, chip, client->irq,
> > +	return inv_icm42600_core_probe(regmap, chip,
> >  				       inv_icm42600_i2c_bus_setup);  
> 
> It's only 81 character, I doubt it will be a problem to have it on one line.
> 
> ...
> 
> > -	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> > +	return inv_icm42600_core_probe(regmap, chip,
> >  				       inv_icm42600_spi_bus_setup);  
> 
> Ditto.
> 

tweaked and pushed out.

