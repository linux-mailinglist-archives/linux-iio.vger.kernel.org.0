Return-Path: <linux-iio+bounces-7772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22797938605
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 21:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EC51F2118D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A716B388;
	Sun, 21 Jul 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXPDIser"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E24166313;
	Sun, 21 Jul 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721591633; cv=none; b=Zp6G2+FViIyX+lJEyotJqZ1N4HnZI6+7h/cBNGfNIIFvKRRuJ94qBDCw4wzJNfe4v6C0he6L20bSTyL59iPNjacYS9e5+Nb55G2T6lilHuUFQbyAoYiVSDZ81WU2UJW1HuKfR2txyNzCbBGMDbkLH9VRnYKwaZUh1MnAGvYv3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721591633; c=relaxed/simple;
	bh=hir5CtpfC8QUmE/xYzT7unP9yNvoN4ItbaeTmE+oNKE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz7l85fLRyLk7wSr/I18QEznNReVrhW9USgUlqYMaWuPqWFgEFKEwwnNfcrvAl88tTd9UO4QML+oFBcO87Qb2k4aN2o5jnnqYWDT3fyr2+LyyOkWbwVyD8RIyzuqqyIuFtRO1vWJNCzoa15pF7iCqTnKHa8OSYjweRufbi1K8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXPDIser; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so2756114a12.2;
        Sun, 21 Jul 2024 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721591630; x=1722196430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKZZhpboQeXtVa+vYFKGKKS9lBGYWANUraKGcyTycO8=;
        b=jXPDIserx+Gin92QU5YEX3vYExuX1+8SMzFqb2pyY3QemYPbQQWT/4GqlBQwzNjxdw
         59fk85hignTrewEt+IWU7eyUC9G5Eo0bu90OomccqeuJtOp4/IlATSed2EppgoR/y4TF
         s3sM29bxkJ9jF4Wxjil+eENBs5h76ZHljXCpZDxRc+LUXBpy71U7GMtkv/hjfotuBZsQ
         tidV2+8x3OPvykXCeDB7l6vjdYAz9TcXpEAkig6VfPoZi0bB9hxpDD8qMYsnpfoWlp/b
         wP6TrW8ap17jxpe0I2XwBoQ1xd5yvxbFrxXiX0xVaCOPsTymOienaOx6SAk7hLEhbJ4o
         aKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721591630; x=1722196430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKZZhpboQeXtVa+vYFKGKKS9lBGYWANUraKGcyTycO8=;
        b=Jm5KhsiGMS2eWGJhxJjx5QNbe2zQuA5DYYt9UrM6DK8g4+3efdSOHntfBMUi4lJngp
         wtg5KCoPLXgysAzvs5FRf2FhyfcNTVdymCM0TSk9kg05QtULiTCcV20lV3kg2CS31bmE
         6GS6Q+AyK73xzK4at0rL5wd60Zb9FEE+LrCSyn+PTCrJNClmhBgG7KbzfnGX0mx5zXpG
         vH6XcLeQfa9bHwDzSLyTULnl3iEBayz1xLdAf5xNs01wSEnGmb0JPhiiHyZwbHuAfOLM
         XZ9BtENYLYhs8OS5BUnnRTbmfrYnKYsEPrWouWQljCgiQKoPCqd3eTAJs7SJwknKzmAo
         OvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWs9iCBnn9VRs3kskTBUlMTmzF8sHkJUjQ/ycLXS2NUmqI4HmNYzSDB0q6HOSeaFiECTwWZCEy0xvjZ0cjVnnwNyVl/x0qnIU+nNcsPFWPsQxtt+o50OZoMAKHkstj3Eo1YIwKVjdsTFElg3qIryTgLQWqqYOO5O2Lnrh+IGGoI4CUHDQ==
X-Gm-Message-State: AOJu0Yzj0Q4lTb14973P6Fu6fbQIqNLvonBU7NgOv84ylRCTAFa0vLwE
	hi/4Z35nW1tcFQyodtLUuRJpE8RY0Il5WqHIglY8wNem0q4uo/8T
X-Google-Smtp-Source: AGHT+IE7VXpNTyNyV/VDDffEUyQ6IiE5yqVhjgkT79+tNvq3qP+S5lOsSwQCqok8yihFRCIK0ZUd8g==
X-Received: by 2002:a05:6402:1d4c:b0:5a2:22f0:7f52 with SMTP id 4fb4d7f45d1cf-5a479971cf4mr3995153a12.19.1721591630057;
        Sun, 21 Jul 2024 12:53:50 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa3505sm4944896a12.34.2024.07.21.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 12:53:49 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 21 Jul 2024 21:53:47 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] iio: pressure: bmp280: Fix waiting time for
 BMP3xx configuration
Message-ID: <20240721195347.GB325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-3-vassilisamir@gmail.com>
 <20240720120636.38b9cdcb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720120636.38b9cdcb@jic23-huawei>

On Sat, Jul 20, 2024 at 12:06:36PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jul 2024 23:15:50 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > According to the datasheet, both pressure and temperature can go up to
> > oversampling x32. With this option, the maximum measurement time is not
> > 80ms (this is for press x32 and temp x2), but it is 130ms nominal
> > (calculated from table 3.9.2) and since most of the maximum values
> > are around +15%, it is configured to 150ms.
> > 
> > Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Applied to what will be the togreg branch of iio.git and marked for stable.
> 
> If it needs to move quicker as we have reports of problems from users
> let me know.
> 
> Jonathan
> 

Hi Jonathan,

Probably no one had this configuration up to now so I don't think there is a need
to rush it :)

Cheers,
Vasilis

