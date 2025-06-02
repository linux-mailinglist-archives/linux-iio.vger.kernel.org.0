Return-Path: <linux-iio+bounces-20173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B47ACBC6F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 22:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A948188EFB6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7B1A841E;
	Mon,  2 Jun 2025 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvwoNwR5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367132C325A;
	Mon,  2 Jun 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897458; cv=none; b=U6WMw2JEBGM1qGMlBIFwbrmuz/wybAFvJdSTJph8Aq0EOxDckhrJyA2saY8QoYGfvlbZIMr1TGx3kiZd3HmaeS3BMTpceJu8FL9hrjQA9JvBpa6lIaRZjUCwVpeiYuSm0ZoTIgweRP5rzhoFb02OszcFp13rt7X74kDloo42As4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897458; c=relaxed/simple;
	bh=NlXKzTfQ84KrvgHZy9hsZqG5grKA8dB0f2XoNKdyaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHC/NGh/iozaFdIrnpkto+yci8Vju9+JijcSTy6PhORSaCSPnzszzT6+8tphNtyVzfLuUryZo/aE8vREBVEWsIltQo22lW1fAr6dOBibeSIR62zPctmS+T9fVPtS30WbtO3BHR4CF3GXI2GaM5bGwuWKEuTkrlsmR4X4TiIrsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvwoNwR5; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e47c2a9cdcso3598223137.1;
        Mon, 02 Jun 2025 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748897456; x=1749502256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiO3IyEEtpHhBw4G5mK9LWwP21snxnHQkhTZqtK2wKU=;
        b=SvwoNwR53WI3LK+yEQguSFnILPLoebrxCdoVe/YlsvPtDXVPGwsmKH/lIS2HfGpQpT
         lunJJeIVLOkChSFGjOrFeJIpC+q8OJndLPSksFG60jhytGhzLhv89Q7XxJLvJ68OHsvp
         IofB/056EmW9+4ZCiV/aeHZM1csiHhHx+abS+tgM/Vt/PnR0VMePMqgZcMSN+pqyDk2i
         kPvA/7scxj7hrFOFNiuFBQjM1mUnJ8c/j7KpkrZ2zUcm1TP4TXQvoSHqexfIz+zAYb6o
         BVEWhugo/M1dO8JOaKljpc+Ux+GMt7Fy/PXe7XOrn4qgWej1UvQLSEppYigWyoZQUIFS
         Fkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897456; x=1749502256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiO3IyEEtpHhBw4G5mK9LWwP21snxnHQkhTZqtK2wKU=;
        b=S8TNilIYiW5wp7ffyPfn5LLElV0kNUuGp2CLpvZk6QiraUfNaZnUrxEN87hxMiy+SC
         fI1s2cLlvXXpDkYtoIFTAjtCTBffNrjtAV71Fv7VDISufuAprM9HT8NkN/RWOSYHIxnA
         p/VYt3bf9VLCkIljSo3bwwF1lsmZyGfA2J6M2uv3DfhveZUB1YKVaKbFCT73/hhweWrF
         Ne79fmFhwjFNmE4Fk707aKBCwe+6qAJ+RWE2DmKTOWMk+anyO+V1HNddJeEnzLjXsskq
         zmfJaOQOnyUmD5BdLRvxLNkMYS9Aldqj7o3/MIDYf6KC1Jfwol4SUrUQSc62/x6WFJX6
         +7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUtd3ycHeL9YUoiL4IaLP+Bz/QXeM4IU19LI1gAdfDf5OXxNiYuDpLSsolt0bfbXGDiBd2OJUeTbxMJ9mw9@vger.kernel.org, AJvYcCVFGqDnVpwuefxaM2lQA29wmUCgFwonssg3OiakaqcfO5lE58ULvt9sZY+cDnLSjpC/2agLgrSqKSJA@vger.kernel.org, AJvYcCVXjUHxQlmcTJubKMA2+shuK9031XohAEbcFm/ERYe94dXEpxCCkPChJMDkqncfEmrv2lIV1MIW/Mrk@vger.kernel.org, AJvYcCWKbASpM3Jv6A3QD7RCNdfedjP/oi6hHERIMeIV7rtSyF5/oc9ZHQ+5onfL4qw1z/oupcEi+7ToxoYiEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaQjE70pmXmF1e7649yRJ5rwt7LrTmNNJSSZjOnV/99E4ebb4
	b5wv7LULyEVexXxPdtl/0bTKTmw0vluZYIiWYhQ+ZPJ70lhIyJbdlu87
X-Gm-Gg: ASbGnctfoBvrJlAt6n/5mccA1VvKJ8zOGiFiIXjcRQOWnoy9KftVyjFD1/tW5t23DB4
	Au0Us6bY4uIpF/5OzOGCVNjzqFPk4MxpX+tzCfjGN90LeAiZnQ1mBzKZ54owdF1ReI7yUxtIVCJ
	vbn10Xz0gUAHA4J1No4grBtyz8rufKGtz5xxEXl1a3HwBrNKXqntKwgxNud7CSRohXjhL//ozc6
	rV/bWldscszupgIUzDt26Rv3vdISMcUnggezsMJ24dw5v2Q5cg2+QS7fYqLHrdj8Dj07v4Nq0wY
	OAyOMoBCBpiPci0LDGYEicZJ7/RpCJYUni+FexOO6hgtvebbICiY1+XibkE=
X-Google-Smtp-Source: AGHT+IEyc/C/kDrqwnFBLuHF8VOoLVDz9m3jiB8VnRgP61h8o7KLKM7/JyyJnW4aCiOmIV2uM1MbsQ==
X-Received: by 2002:a05:6102:54a5:b0:4e4:57db:b28a with SMTP id ada2fe7eead31-4e701b0794cmr7413604137.19.1748897456112;
        Mon, 02 Jun 2025 13:50:56 -0700 (PDT)
Received: from localhost ([2804:30c:406b:9100:2a26:16f5:c81:e61f])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-87e2a3b624bsm6825822241.28.2025.06.02.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 13:50:55 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:52:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, nuno.sa@analog.com,
	andy@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, brgl@bgdev.pl, dlechner@baylibre.com,
	lars@metafoo.de, jic23@kernel.org, krzk+dt@kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <aD4PD4tBdbTFWNju@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
 <174886697998.948762.16527380744873036141.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174886697998.948762.16527380744873036141.robh@kernel.org>

On 06/02, Rob Herring (Arm) wrote:
> 
> On Mon, 02 Jun 2025 08:36:24 -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
...
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml: properties:interrupt-names: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
> 	hint: Scalar and array keywords cannot be mixed
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

Removing maxItems from under interrupt-names seems to solve the issue.

Thanks

