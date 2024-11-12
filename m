Return-Path: <linux-iio+bounces-12187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7822C9C5E61
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306F91F21D83
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AC2144D0;
	Tue, 12 Nov 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTlJSKZx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333A20C461;
	Tue, 12 Nov 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431058; cv=none; b=JVoWeYWksIO2dgVfUkWEMfAzumtX6pyAuZuVsVJfDVJV3Egqz/eV+ttW/OAVURw8knP0v5moS3Jst9521rL2AgROtt33jtE8gIEFvhqs+rdqvhGyOxtpr71MKHUC9vM8xlNsE7edqcReJCXC6/zG0MQ/qdkwEclH0wFd6Ot15D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431058; c=relaxed/simple;
	bh=oCR1TRwTXEy0FAzrzB6QX1TyFzAg4HkdrRdVtwlaD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVKeyGMpCR26DgCnHywYpTd8SZ8e9xOxs5zW1rwspOVxBR/jUz4KBwRqcnqs5ArahHR8MDLMVWDLfysa+u+O4xv4PJvTzle+uIaGk7bQ4cHiM8g/1CIAnh3x7c8FDchbPfHlVFo+192KehXmvdv17kXIqNFwLOx1j8cNnaJ0Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTlJSKZx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c767a9c50so58280285ad.1;
        Tue, 12 Nov 2024 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731431057; x=1732035857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TzAZ2wI/SsBv8e6rWIulIn9M+uufamHvYe7/o5Pmqo=;
        b=mTlJSKZxx0ZOJ1Aa9DMhFcQPG2VL5eyV8H61NlJKRgai4KE5h6SYE9WGC6/ckH0YO6
         j3723koFLuHeZnVh7KJVKsYLL67ALXsMEVqEbip+zQPtR5gcAqkUq/5/Qm2pEyRK7vvi
         YO0l787r8E+Dz2Dtc556AIpEhpg/a3CSdxw5EQ3dwT42Lv6QymOmMVoG+pz4mg+IxohP
         TT6AJVYWhj+ubmSYZ1W1ISEYUk7uBoq4StJKyiLxNPdsOqGZyQkyQRyuTXzIFuG5maCX
         zeR1yPGg/uRxOEboFKgXyMK9ken+M07QhT+gneOYgCiHwpfZvXnuXdyRpH8SPxX+zF/J
         XB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431057; x=1732035857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TzAZ2wI/SsBv8e6rWIulIn9M+uufamHvYe7/o5Pmqo=;
        b=XX8ZRcrOw3k9jB+SdArETlBY8AtWs3YrIK8YXLipTZVbkbj4HzVJHGM4dDlu8JLWit
         oPCdsQ7pVPDXIgQr1tqTVWJ4nXE40IQbtABjsHKwvSz0cXERVKY1JpDD19DmsXE/yZnq
         uuCR3XdbGCJIxOVr72mYDcaL4UzQKNuIbgzJl2pe5Wti13gM2o7rjkYElnsAbizn6scd
         8L9mmw7b53N+FLfNfqruVYJSyIuOXuHe+j/Yb17EdIWhmTE2cIzYFuR4QarZSBG/nq2P
         KWFjS9YVnqc6err3+xnuzgctGC4R+k6Tp9CKce4Anmu+MKwn6gqnUjN5IQwiY67WhnDL
         DHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhtaaI2LZQiUZ7SqffEXx6O0dqP5kv2ZyDDSwPNVVmp2pr5OSx5KQLLNyaGOtkenQbvlCtAECFcHtK@vger.kernel.org, AJvYcCV+n1rr1Ejx8kMccfztAW6csSexdds8HZecEoyjhNi1K6h8s/qN92BtEVjHYp9x+TzoAoYJbywPhKFApY4=@vger.kernel.org, AJvYcCWC5ChYhZPM5NPVuM4iohKAMTRIPyQci5iEkzl30e5PhoaKBkhFGZ/jEa64sKNyGBamnnX9IhdYPP4l@vger.kernel.org, AJvYcCXfwYEdMVh2ENzotWIhhhKyzsIiex8Q7EFMY2w9SiuhS5ri4u1GGG1ZAvItvk1RxQX0TjW7syCf5KIZrbGM@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8qZmniUcaZx+WWUport0rOGmu+r9BWD3oytUA2CgxW/TNeHL
	vfPYd1fn97cLbyeAQu+DT5DfNYTVN6Ykk8g6SGpyo8/HIff4Qozc
X-Google-Smtp-Source: AGHT+IHRVCkPv69Giv9Ck6e8LALo+6Vd8jA6G0f2rPbTFybc2LxVw7NcogCrIEnD2UMIGigrnmpwQg==
X-Received: by 2002:a17:902:c405:b0:205:4721:19c with SMTP id d9443c01a7336-21183d55b03mr238707535ad.37.1731431056592;
        Tue, 12 Nov 2024 09:04:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45839sm95869765ad.143.2024.11.12.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:04:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Nov 2024 09:04:14 -0800
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
Subject: Re: [PATCH v4 1/3] hwmon: tmp108: Add helper function
 tmp108_common_probe() to prepare I3C support
Message-ID: <ec1a3a2c-e1b3-481a-aac6-e0826c570ce6@roeck-us.net>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
 <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>

On Tue, Nov 12, 2024 at 11:51:59AM -0500, Frank Li wrote:
> Add help function tmp108_common_probe() to pave road to support i3c for
> P3T1085(NXP) chip.
> 
> Use dev_err_probe() to simple code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

