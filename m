Return-Path: <linux-iio+bounces-12754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9819DAF11
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 22:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E8282459
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317251FF7DD;
	Wed, 27 Nov 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWlDBnZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A97F9DD;
	Wed, 27 Nov 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744044; cv=none; b=GcMOp/ld9ESphjyp9IKs0A7Oda3h3PhvRnzq8ocdmNEeE/3CDlG3IU8pK2mP3+97rA+8+p00fLpclITUoC9DnfDTaBZRZyM64pF19M6qjjOqNdhm++yUR2sEM3NfTUqz8qDlBNOBa7hu2Qw4toHTGDR7zgnaAQ7XfsBPpHhgl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744044; c=relaxed/simple;
	bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfnGVkA3KsKg34kxs9Cfj4J/9j3DAqYnIrrcCwgkaw1KO/lgqjqgAnEwYpBeycA8oSsQ6LNguGGs4I24CXBNWtX9AnR2lOsxGgydUbmJ9881ZGegcoPuHT2fw/tI863tLVQ0j1mZyaF86nVt006UuOil/gZ41zvCA62XDEBZy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWlDBnZE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso146394a12.1;
        Wed, 27 Nov 2024 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732744042; x=1733348842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
        b=YWlDBnZE3xR1lEqtAYQ2wUxQMQN7BJyo+jfEclsTsALTXt5+lRf5o/toje22379VyF
         MRPyxzT7YI/W/GkYDiqfvdy0xajZXbWKvfpM5rdS9H79esoDPXyce3ixJB6P/KwVijuK
         1z6zT+E+/vz6o24F3zfIOV8IrOqLnMzRiub7NcR10Q5WiwdaXSSL9zn+KVsgH/VSKdjM
         oh16tTR2fuBZAeI14owrJEwVmwuyKXt/kaLz2pBuYibspvTsRA7UAJTR1WygNG11L3kt
         NDXyNKsbjDSIPu0avZJ1NDeKFEG2zFxRNogljwGObyAoUyFRRYF39TfCnaM1SsPITWjA
         CdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732744042; x=1733348842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
        b=hZBTzCbpWJNx536u4+its0s+t94sfup39avKQh+Cq30oaaLSqEHJkvrt7HoRGlv4Gd
         k6b1zAQZpMY8sDCHW4dBgKeirb+QfeUxVV3/xtwVQ0z2kcSRzo2Sy8o431y43b60XS1P
         ioQUuN1/ypRy5a3Y65hfvnJYLmghPWnmHC5RkCRf+TEhTvRqkB1CWDxIR6OvxmLljXO4
         NF5xIlq8/ZXTxmnWAWfnTi0qFR6wiQptG2TK6/xrxb1KGH85nlNuKnffZfjs7awwaewM
         sEq8mZf4o1L9KW6RrH02GUFExsJcInvjL9IcS1IM/sMwePKaEfylMNsg4xuQg5M+7yj3
         j8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWHv6kUl6sTF4VyYRAplNz45lo9dNJ7YP7/hYRe8YNHfRArotJePQQN43Qw+dURAopB1uxFMKQzczrp4Gxl@vger.kernel.org, AJvYcCXgeGHNOQojpox39pAtmyfNVy8p/GRhPQuY4a9RbGuIg+lo1rBi95ZSEDFJvmUOVLreQDYRjo5I/rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWGez8B3mN3m3JCM3rTmiQ4rbRUb+1ZttPb3Xc8aswzG0dJWU
	rVSpRwawVwZmDWgkY+XBV2BXbAcXxwsrYD5pDvSZbz+1iWLx8tXC6BCY8bBQ
X-Gm-Gg: ASbGncvOLEWgDrLCpvC4v1uC0r48IVB9Nhv5daH9jNWIyIF1Xjk9/gZgqLaWwcTn4Ij
	kZXtCQcpoTcw+Nx8QQWF14153am1uudUCkhujGNcbGJO82OKeNXcMeMpgeaipvv8wqVvkupO6Io
	MhIQxBuA3tbd43sxwTSMa63+aOAm5o85fhj4AWlV5QRivp+WNuO3XVuE4nAZPHPoubew6lyadm/
	FcmjmV0u6znjd9JgfyZ7IYEEfYTT+VSFJ41bqfz25ZZaIQosQtu9CP/nN05jUt34HiNiac=
X-Google-Smtp-Source: AGHT+IGO1p8z+BkFDZ/aMGUZPaBfO8kRv7rUfm8G5Wv3yTnsyQCay41p986puhzumXjx9S8j5VMpZw==
X-Received: by 2002:a17:903:185:b0:20b:a409:329 with SMTP id d9443c01a7336-2151d2f048amr11176105ad.5.1732744041900;
        Wed, 27 Nov 2024 13:47:21 -0800 (PST)
Received: from localhost.localdomain ([177.10.10.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219851dcsm248355ad.197.2024.11.27.13.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:47:21 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: wbg@kernel.org
Cc: david@lechnology.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH] Add COUNTER_FUNCTION_DISABLE to the counter API
Date: Wed, 27 Nov 2024 18:46:54 -0300
Message-Id: <20241127214654.1259-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z0eAg9HRlYlCy25H@ishi>
References: <Z0eAg9HRlYlCy25H@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 05:26 PM, William Breathitt Gray wrote:=0D
> Hello Rafael,=0D
>=0D
> I wonder whether a new enum option is actually needed in this case.=0D
> Wouldn't the Count "enable" extension already provide a way for users to=
=0D
> stop the counting? I imagine the driver would determine implicitly that=0D
> the device can enter a power-saving state in that scenario when counting=
=0D
> has been disabled by the user.=0D
>=0D
> William Breathitt Gray=0D
=0D
Hello, William!=0D
=0D
Thanks a lot for the feedback! You raised an important point.=0D
=0D
I would like to explain my reasoning behind the implementation =0D
so you can see if it makes sense or if I misunderstood. Basically, =0D
Texas drivers are described as user-operated through the sysfs file =0D
system, echoing some directories in /dev/.=0D
=0D
The requirement of my application was to communicate at the kernel =0D
space level with another driver, and to do so, I retrieved the pdev =0D
with platform_get_drvdata(), which was allocated with platform_set_drvdata =
=0D
in the texas driver probe. To apply the required settings, I used the pdev =
=0D
I retrieved pointing to the fops, such as ti_eqep_function_write(). I made =
=0D
this small change in the module for this enum value and a patch in the ti =
=0D
eqep driver to handle this in order to establish a safe shutdown.=0D
=0D
In my application it worked perfectly, and so I had the idea of applying =0D
a patch to kernel.org to see if my changes could contribute something to =0D
the Texas driver infrastructure.=0D
=0D
Best regards=

