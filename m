Return-Path: <linux-iio+bounces-12188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D079C5E90
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4A282913
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2042141AC;
	Tue, 12 Nov 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAAUzoP7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46702213ED1;
	Tue, 12 Nov 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431484; cv=none; b=qmY7aa6eh9NFeLfKePo2o1txw3J1RjaM2EeE6+/eDF8AVtv++ckmYJNOYCoPTXkiL0cYLG8dysvEyfbmhF5RoeVDcivVG5R7FvSHeiM7zoWAirY7k4cUmJW8nyGlkEipB/90sAEF1uf8nywMInXfm8pp+JLKqoM8iM/JiLzFyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431484; c=relaxed/simple;
	bh=9qFLxQuXAwUMz3A693Ta0zMDeVFkOg0P5FQheE/cQmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuclZYlKKWoiJP4Msyu/YXvSgDiG1T6ZlQn+g0JbIAeFXD48DQ6gvpkrpoJjyt9t64wj/RaAt4Urnxac2ucMXw+0V07D++q3IffeYWFhdxD6YADSW5d4q1RKbmQBYG6qfcrIIFNf5gIOEScPO9BdMVmaUg22+5NW0+R7xpjt/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAAUzoP7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720e94d36c8so5887876b3a.1;
        Tue, 12 Nov 2024 09:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731431482; x=1732036282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c6OWgQF/ejcqVQp7h08DgprnfycsFPIP9B8O7D4XkA=;
        b=UAAUzoP7ihnFQHFawDWunmNJTJeq7Hm0I+MMEHZIZZAOF8F8jKh00jnO9dNk8Xt5Ob
         R0EZz9cwOJgEMVArfcz7nPjg+kdziLaLZ32VOtIDUNJOMXk9iM/XCdKx77mPJSh6CllK
         l2MK0E+etFQLY17puWsJRhoxmwqGfBlUcFUIeP7Oa9cmmCNxCm5UZJHavimttSD08aqe
         CMykEdfrxovqncLqauoTsCUmSHmmA0gJSktxSe+dV9gERE8KXpnMZ5mJk3tRBR0nPeSk
         X6JdBbB9+v3upbrfbpCwFaUhF4mgrB7qx9UHD/ddH9x0cqtNdMiaBgf7oI0IDclghr9I
         62nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431482; x=1732036282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c6OWgQF/ejcqVQp7h08DgprnfycsFPIP9B8O7D4XkA=;
        b=e0OJK/JJTcWxNFXOZQbW4owVuuaD9vo+V/mCNvCgN2iRZtcv3+glLMSnrvqzv71Tag
         JujRcSf9F6ivmXsMOs2ulw1c1hvUMXeP0JfavJ/ZKY8dMDM5F5PTS0/UbvcMYxZmGLAu
         RNxmFp2xrt4nG+oAMJ8XMxXkAxp57SABNKwJDeQSuJ15tbNiTKU7wW3CrSTnitPmxoUQ
         1U3lJVzO7tHKobZCmTbnGMybY0xdSrvoonrgAJ+BigALLgoAs6sEHKkPdYlgZaVV9Gk8
         hEgScjupleCWiGRf7hMX5IiCy6MfIm8ZubfNct6X25c+cRyPkNplkYY+ObFJHJTSKqQi
         YI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK5UIQtyIGqQ8iJ++VK9Hxo8l1TeiRL/lOqwkHCWVl8XMOcR7ztqy0OS5pq8iVQfWhs5iUQB76SJzGN2o=@vger.kernel.org, AJvYcCUiAQrvdzuml+kzSV00oNduYVI4CEK9cT9S04XPaF8U4jS0wG58C7Ivcuffzv5he5EtzYyHS9BTueLe@vger.kernel.org, AJvYcCVVL1ueQBtdgEv4YEzsR4KR1hmc4DCMY+KufA4KdwuBwjUFS+TUAsuOxFX5lCLaKl5vPTKxkXh8Xz/FxHl8@vger.kernel.org, AJvYcCXWkYFH9QBIUQW4102iee+M3jCMkTCa+QgvWoeg+kAexC+4yeLLXxn8KPTBv6XYt6QGQgYnJUWZjX7T@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMp3QyhjICM+wls+/Pi8Ma+70vqviXcXkeqj2ZktbxxTkdSok
	QxD0h29NDMqG68r3uo5wgnMMSs7nhTUnwwIXtWR4ltYPdU6AJcBP75oe9A==
X-Google-Smtp-Source: AGHT+IEB0XmDsy3B10i2uTRC8VzGGRmiDyjY6Ju3LHYSB2QDsh3LoZZxlsq6FBHih7bSCohEPX+QNw==
X-Received: by 2002:a05:6a20:3944:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1dc234afb33mr26913887637.14.1731431482453;
        Tue, 12 Nov 2024 09:11:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a189e3sm11424545b3a.136.2024.11.12.09.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:11:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Nov 2024 09:11:20 -0800
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
Subject: Re: [PATCH v4 2/3] hwmon: tmp108: Add support for I3C device
Message-ID: <860c243a-f6db-44dd-bbba-d4c01dc7f9ac@roeck-us.net>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
 <20241112-p3t1085-v4-2-a1334314b1e6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-p3t1085-v4-2-a1334314b1e6@nxp.com>

On Tue, Nov 12, 2024 at 11:52:00AM -0500, Frank Li wrote:
> Add support for I3C device in the tmp108 driver to handle the P3T1085
> sensor. Register the I3C device driver to enable I3C functionality for the
> sensor.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied.

Thanks,
Guenter

