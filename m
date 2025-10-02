Return-Path: <linux-iio+bounces-24682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F75BB57DB
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FE23BCEC9
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B62737EE;
	Thu,  2 Oct 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkmelcSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73E3BB44
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441109; cv=none; b=o7x0T1SkOgQTtIzZvRyHZqa+JPIrg1MrViO5UReUGAt7LDyGtlc5qyHFvfygcNGDnPtcn4wOaXGJoFODIdrTNiN348/45CscUFrhzdnMKVSAh6dZsJG1EbFGJh9y5eqo90ubBkllOYnEzBKx75YJDczK9DmwFlqTzAuhtjftCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441109; c=relaxed/simple;
	bh=9dF0uJ3ISA22smG2brOHKcN/I7pK9c344S34aWAoh5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reR+JwoCiYyY9h9nF2qLflDIdqiSIzgEGtkWN/Ub7sX9OsQe+9TOYrNx6GBNE5KvVn2cTKvgRN3xkiF8xuc1ejh0k6740Uk+4vVDcENuqgy4D9GvGh571k5kDPEmYlWZuTPaJ/8VKFdgRanwj5xGGEghWJg7b5yesEyr3tQtORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkmelcSG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781001e3846so1528557b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441107; x=1760045907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=AkmelcSGRu3932uTOYGDJEADP0HTBJOxNAfPgccn2+o6RdZ8YtVXo0CDAzlZ14Xvc2
         XZRbfX1YLFNG48memWUdjuYGcp/m2hKt5GytLNmIE+6OWaYfNcFLNHYPNsbWCCrHkX1q
         7criSdxCPrOUEp7L+0htUYmfrPb12WwUa9VBwMNXYCvfZDOUCaHI+PC5DTVgl4A0tap+
         jsqTkFS+UlSVvD9QVgyoHlbVKTvKrP5u4xlqqJ+DoGjrgvRZPrkwtTfgrTjOa/WTpVv7
         MIO2+lX9rwFJR9N1iNveYowQDWut6JvP9PUIOcxvCzkKtqEstcQrKk8PXjDm0/Jhokrc
         2sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441107; x=1760045907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=NJ25dosLv4H8/tyUoUNygl94drPqagBKjNugfdZ3PyaUdMOxhmkn3oOlj0dl13h4De
         /At+7guvWTJTiKBKUlN3d/xqNddRLaUNd97Cqf/UgZ44eyEwLM46hdKBJRD+SELni6FP
         YS+Z9ONu/hp4I9G7FzUyNHWTISx8mm/2zwXn/zfwpT93ZSkDImJOF4f/FB8gcIJiezE9
         /am/RFxtmC+6t7uW0xar6A8x2C4634OUD/XaEWgLWcZ8WmFQNPM9VeJH9S4BDrJDNYUf
         u50ItZAfZ2zBaAMkwRsGXYIqBpgadYne1QSmXzVjmDDh5ovz+zrXXSkp/HBV5UlllMGv
         qTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvQIYAnSnLH3ooSpvY0r8VWJDEq7IcK3xoVMWGK0pfAwusXFhFphflRn0yYU7DweosZZjI2h+gF8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4IOkhBaXFAh4l4n5chOuvTDdC6nK9jj4dQB232zxQysgP3xW
	HgZVJI4ghxMTxm15/4CC5JUobh2Ho6oPLNIZBzNumK8K/CCVfFJkAZEk
X-Gm-Gg: ASbGnct3DHunHzOSlXr5/FV7UwBaNHUbwv/yQIV2ScA8fPOPG6Cn4+xMqhsMbslALPs
	c/JjZxri2QW9cXRwtSvpv1j4xDzzjywBw/+u63b0O+x0htRQHkeT9cpz6Msz2PT6/aJqNuuRVj4
	Iu0cSRTECol5EW8QjFqihMVd58eAWUSEmxRdRhK1abAtfAbzb3UCNC8GJY7ghWS3ISsFLeRH677
	QVj32HyXcinhGj2hVmWyTBfbc2UmjUtcwybbcbTbKIXiVR5A00C7rBujURvyw0BgRuu90VUNUEw
	AJuIinONf/9HxS6GtK5ba+zD85NZGUQrbYlvyrRnf/VfxY8sfWFfVnM4MZN318EPm6MT3hIsv9y
	rXxgaCrk8Z61VdXcyrEth4TuxhXOo4xvmz4a19x56slpW2QUa3PHbci7R+7U=
X-Google-Smtp-Source: AGHT+IHKI+feEMtSNCRgXeWWSvyIHg/eMcVz9KANAAoF8cg8/wBIuazCOx9v2nwjg3cKvHoW9MEgFg==
X-Received: by 2002:a05:6a20:12c9:b0:263:1c48:912f with SMTP id adf61e73a8af0-32b61dfb34emr1222197637.12.1759441107306;
        Thu, 02 Oct 2025 14:38:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074549sm3020231b3a.76.2025.10.02.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:38:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:38:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 5/7] dt-bindings: hwmon: max31790: Use
 addressed fan nodes
Message-ID: <c7c23305-d53a-40e1-a783-9ea8598c96d0@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-6-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001144441.310950-6-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:39AM -0500, Eddie James wrote:
> Since fan properties can include reg, the fan controller should be
> able to specify address-cells and size-cells properties and use
> an addressed fan child node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

