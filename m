Return-Path: <linux-iio+bounces-25597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FFAC157FC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEFD4260CA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9F342C88;
	Tue, 28 Oct 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJXOPB2D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CD33F8B1
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665436; cv=none; b=Azs1TF2enhkMV96+LL9Z+k6qlajGieEnNI3vT0QJFKyi3cudTKC3ZcHEu75scb+AgsBaETlym68ClKXEHhJVczw+a2+Bll4QwI9LrpxZfq42j+LSYpDKe+9hNa+J/oPF/1ejvNy229km5A1jmegMYnt67SpE/QqVPcB3Bg6Xm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665436; c=relaxed/simple;
	bh=omCv2xt9sfDV1Sj6ZTG7T9nKYAOrU+rkJnFSocGZeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBh1se+Y0SYaENXCWmVWozSsjxQc7HJ653bcZSS7BwyDHLla+ifx+87T4LE3oT2nHV+LTX5bMY48UcR7YDOvefBn7yg2TkLy7BL25D9qPYZspcdF+PPYFyqH7trC7OoQBXKOcdPUAIoo9vmaW7XV/XSRX+KMfX6Q/XZxeBXIw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJXOPB2D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a2738daea2so5228993b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665433; x=1762270233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxRG+6Pho2gqh+4Q9HbMHt6ljAWQLQ6AqeZiXpRBEU8=;
        b=GJXOPB2Daxx/pmTMYjIE5yzSaiUPH2jbPFwNqtzFYmwU5rMQvOgmyO9f9QxAC6gk4b
         oxDGmtN2a/n7nHdUVvha9ZXRhJK+JivlZa2ffR3BasGxySA6ctSmLNjPWcfNcO6rHhKt
         ACRm1BTiCTGEDHAaEoXWAxHbXtFSDTnjyVffUzrUZIc11acr+4We5yHykjuEUHghOBDY
         GdQlGh/EKOOxm9r7xdNtpq1y3UEW+cCUbvPeauwmUv7yZS5p63Ad1Wmek4UgQUMz1rGd
         mmE/lQepa/zvdoJ6GOOSKAXfbcHV/4/UO1lrSYJXWYFEC1JPCXhS7Plkd2Z9X5NNEf8y
         AD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665433; x=1762270233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxRG+6Pho2gqh+4Q9HbMHt6ljAWQLQ6AqeZiXpRBEU8=;
        b=McZlI3XJ95iEksMNF1mmsc7q0KFBDfXTp9d2/iXuaKv3jZNn0WBii3y1X89+35ZaPh
         HKyFL/erexbbvfpWZdvYX2yo95yTXiQUL5ZA0aQeTrwEY6kemtcf/W+VMg9xCuhrrL9e
         xMvZBv1/3SmDPaiVLrVH/fiTDkl3YsBckEu7gtuqS8x4Nnrrzdg0LJ143jlZwd0xJqfb
         qoRiPupTrxRrQHe77EsHg7SNzFHBMPUeNcAHw1VK4MHOm+KrUkdgdl908/StO8ayGF8O
         zqysI0aImfOUuYcpdUduuqyBWqslV+LgdwIapZGFzjueeQlIIovnjBhnVnjGGiDlkUTO
         GWbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLGjNW7wREwkbkM2UVzuO1TqE/0wd6H4YH4QZ+akTO9osupO5zWoRf+cFpNL72BpbtNH4KZnwM8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lWlxdgWaec5Qb8G8IFwVMylUIppA7Yr2cYj+pv9D5tPXNWoQ
	9uNBnXY5glV90R7i5QsDiELQSznRpXW1K0UROgqITiYCBhMFrRWQ02GW
X-Gm-Gg: ASbGncsGPrTWOBi7i7AZ4aRO2hA+XzjNcxDe+eXhwBu4imPHtwJR4zQrGRU9KVbdT94
	BAVzXs0dWXEBWHhy92iR91MvYG71JciFm2gF5mEFk/V2pX7hmgwHVPRNYYQ9bTsZCtk37xejzbj
	uD+uJZTsJ20Lc22YRS59G0wWfMNkktLoHrKJZZ96JUqy71uAHP7KrHDX9plmeBSA3wrY63d8KBX
	ZlofVeYEYnab9ImgRBCcPJOka45QzZooZ40YasQ2FG6H4YN4Jl1I4eyE3/mme1lYlOqPNoG53Hk
	3DWqU5bB/Q+TdYBaJYID0hPLcqyIVzNoA9kDGoRI/EQG/8D7b0QUmKsm05hGCYUrXp/3IyTgGkB
	AEQZO7fxUnwYVuMWO38zdO2II8p+tMQoSose5ESUH/kL2CbohGAGR3Xy1SKhw9e9VuqNDw0ywSV
	gF0PSjzYacvpbg
X-Google-Smtp-Source: AGHT+IGPgJpaXpS+qGfCVwjy5qKW3g9pioh78AOdOiTvXDrTwpjB0TQBFCGFxXT+WLbv0GqTWaiN5w==
X-Received: by 2002:a05:6a00:3926:b0:7a2:8111:780a with SMTP id d2e1a72fcca58-7a441bbe4a5mr4578185b3a.2.1761665433210;
        Tue, 28 Oct 2025 08:30:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414011acdsm11958328b3a.13.2025.10.28.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:30:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 28 Oct 2025 08:30:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/5] i3c: Add HDR API support
Message-ID: <c0ee9047-691c-4f5d-a273-333a6bbcd5a8@roeck-us.net>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
 <20251027-i3c_ddr-v7-1-866a0ff7fc46@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-i3c_ddr-v7-1-866a0ff7fc46@nxp.com>

On Mon, Oct 27, 2025 at 04:08:29PM -0400, Frank Li wrote:
> Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
> I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
> Technical Overview.
> 
> i3c_xfer will be used for both SDR and HDR.
> 
> Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
> CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.
> 
> Add i3c_device_do_xfers() with an xfer mode argument, while keeping
> i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
> with I3C_SDR for backward compatibility.
> 
> Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
> 'rnw', since HDR mode uses read/write commands instead of the SDR address
> bit.
> 
> Add .i3c_xfers() callback for master controllers. If not implemented, fall
> back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
> all controllers switch to .i3c_xfers().
> 
> Add 'mode_mask' bitmask to advertise controller capability.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
> one i3c transfer. for example, can't send a HDR follow one SDR between
> START and STOP.
> 
> i3c_priv_xfer should be treat as whole i3c transactions. If user want send
> HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
> instead put into a big i3c_priv_xfer[n].
> 
> change in v7
> - explicit set enum I3C_HDR_* to value, which spec required.
> - add comments about check priv_xfers and i3c_xfers
> 
> change in v5-v6
> - none
> 
> change in v4
> - Rename enum i3c_hdr_mode to i3c_xfer_mode.
> 
> change in v3
> - Add Depreciated comment for priv_xfers.

Deprecated

> 
> change in v2
> - don't use 'priv_' since it is refer to sdr mode transfer in spec.
> - add 'mode_mask' indicate controller's capibility.
> - add helper function to check master's supported transfer mode.
> ---
...
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2821,10 +2821,14 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
>  
>  static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
>  {
> -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> +	if (!ops || !ops->bus_init ||
>  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
>  		return -EINVAL;
>  
> +	/* Must provide one of priv_xfers (SDR only) or i3c_xfers (all modes) */
> +	if (!ops->priv_xfers && !ops->i3c_xfers)
> +		return -EINVAL;
> +
>  	if (ops->request_ibi &&
>  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
>  	     !ops->recycle_ibi_slot))
> @@ -3014,9 +3018,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
>  						dev->boardinfo->init_dyn_addr);
>  }
>  
> -int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
> -				 struct i3c_priv_xfer *xfers,
> -				 int nxfers)
> +int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
> +			    int nxfers, enum i3c_xfer_mode mode)
>  {
>  	struct i3c_master_controller *master;
>  
> @@ -3027,9 +3030,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
>  	if (!master || !xfers)
>  		return -EINVAL;
>  
> +	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
> +		return -EOPNOTSUPP;
> +
> +	if (master->ops->i3c_xfers)
> +		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
> +
>  	if (!master->ops->priv_xfers)
>  		return -EOPNOTSUPP;

i3c_master_check_ops() already ensures that either i3c_xfers or priv_xfers
is not NULL. The above check is therefore unnecessary.

That is not a new issue, though. Maybe there was/is a reason for the
additional check, but I don't see it.

>  
> +	if (mode != I3C_SDR)
> +		return -EINVAL;
> +
>  	return master->ops->priv_xfers(dev, xfers, nxfers);
>  }
>  
...
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index c52a82dd79a63436c1de6a01c11df9e295c1660e..7e22f9d2a2ca3f4ab808db50f809efd192c795cd 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
>  				 const struct i3c_ccc_cmd *cmd);
>  	int (*send_ccc_cmd)(struct i3c_master_controller *master,
>  			    struct i3c_ccc_cmd *cmd);
> +	/* Depreciated, please use i3c_xfers() */

Deprecated

