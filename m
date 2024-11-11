Return-Path: <linux-iio+bounces-12157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6179C45C4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076381F22409
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5261AB6E9;
	Mon, 11 Nov 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIyGccWA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEC6CDBA;
	Mon, 11 Nov 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353012; cv=none; b=IY07b1W1qp+ZfGl0tyfcf+i+Hz0WcHz7xV9kvMUrN1XjeF+8h0gWrqcc3LdSb8lxJU40XSi7YAJ3oNhTulSuA6qicgivJPWWum4BH6Q2lFAYjL+cc6mNhjofg40DsGXqqtUcQgPqO7VJC89fZ+cYhtQS9+Dons4TpG4lQwm/3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353012; c=relaxed/simple;
	bh=ANE+3Z4Gyg1tlcJwOYEwYd+wJ7Qoc7aVZQor/12U2H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUWG8q5z6hCaZ+mfXhb1wDrTpHMH+AjxAfQ1MKJEAf95qb5WA8PUyt0jHvNEZiBU6SkXaAeevZIvqNFjapB5OIQJRJ+l+s1numkMRKtun+T2t7XBKRCD1tWvTWH7FMeUYI7QdCqgBeyb0q7lKU6eaHOkKq3LcCvAGTjLdDEmrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIyGccWA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso3909998b3a.3;
        Mon, 11 Nov 2024 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731353010; x=1731957810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG1vbKR+3pDFc8nEwm1ZvVOlqvzLfcT/ZGyivy84CdU=;
        b=iIyGccWAY4R3RFyVcxxbupuVbgu4J8rjhclQKNOmwuwXxFta9lU9oleF/UIaV1Rgg6
         yuKixM1urp8eZ43rieL7tqB3nO1Q5ZzqeI0giyQuUG4jmD8heZ76O6q4AkNTDDex2iOl
         5BGi5F5zj7koPky25sUd1HnG++yd07gXdUjMkLlEuIWMOHSrHfhUV0p6Lf+pDbwF9Urk
         FmTUsS1agk35a0RZ2dAo+OaOxFzarGB7V6Efg+9AyBHvaOPs40QNbX8hVP3q5ruTs5gm
         Dl1E4RSbQdrVvr+2Vbq6K8ehKUtuQYtYuDCAvELtu8bOTMqKIueYA0PbD8HevEK6onPI
         AJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353010; x=1731957810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG1vbKR+3pDFc8nEwm1ZvVOlqvzLfcT/ZGyivy84CdU=;
        b=sYspFL5jl5nfndPUI621Stn84ws5i6z4qBfOzMDFoVkJZ1UGGXGfDfm//SMsboAoyA
         vrIqBDh+vcor33ZcKoG29Axf31UM2V+9ooAvNJTQ2fq5izgYiL03uNtXHFlLDKDWBfjL
         aVlG/2mAECJikaq4CEarH+mecpchzZFucbp8lI1DQNN96Da8uB6WsgKw7NEWD/IVh7w7
         59LfPAToauvqW1dYZo5iF8QT4luEw4bOM8iZeRNtYUmhee24lZPq5gn5N4Y4vVODNtlZ
         NwqAOyhDP9piHAKvQ6pdVYT8Exa/Ato6jgKZt2y7t0sciLsMkVIOZOU8lyC8Lf55di5F
         zGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjC/jWXh/uScC+XO0bmkIsnYMCnrypGn3cvSX4pTuPFp9FfBimvhg8DZSoewHSnwlGnDKOVRBnYRMX2gM=@vger.kernel.org, AJvYcCVip8AdKZyEZ4u5sinqa3tQRIj5Ed+HgM3Moy/PwATXM3xW1K2wB2FUyg8Jfo3COYHRUVSprxlfshDTNbSe@vger.kernel.org, AJvYcCVtzqR93MMyh8tfsn8HTW+ah2nMdEZcCZeyuNC4BRj8cOGAkLBUh016K4Epx/IX1EZFTRY060OJiV6d@vger.kernel.org, AJvYcCW5Wi6nhnxTCCKM7HdN/lqsHJdj78FEtNnPtbC9geVVgoFujTHQ6mCpCo1jpxLjyzo94az+thqLxKYR@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGgF+E3op88a/y2Ml/wLAjY4pc6RGiQP53I44bIGFptGszNJe
	n48FB7n8pidu+VQXIk4g2funYLnxCNu498co/i9BY7ESUvx4YxtS
X-Google-Smtp-Source: AGHT+IEOXb9dMYWoaOSDkxeJwpcmRG5zOxNUAn9W/2lBSOlh8h6XPV9j5KFH5WXswgBqfSkR4E6eqA==
X-Received: by 2002:a05:6a20:9150:b0:1db:f89a:c6fe with SMTP id adf61e73a8af0-1dc22b00e61mr19740459637.32.1731353010371;
        Mon, 11 Nov 2024 11:23:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643cddsm7591486a12.54.2024.11.11.11.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:23:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Nov 2024 11:23:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/5] hwmon: tmp108: Add NXP p3t1085 support
Message-ID: <576b3e70-9c09-4d8e-8b3f-f98a801b20dd@roeck-us.net>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-2-bff511550aad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-p3t1085-v3-2-bff511550aad@nxp.com>

On Mon, Nov 11, 2024 at 12:31:59PM -0500, Frank Li wrote:
> Add compatible string 'nxp,p3t1085' since p3t1085's register layout is the
> same as tmp108.
> 
> The p3t1085 supports I3C interface.
> 
> Update document tmp108.rst and Kconfig's help context.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

