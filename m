Return-Path: <linux-iio+bounces-8958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB79682E2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32430283C1B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345B18787F;
	Mon,  2 Sep 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSxeKpvr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1431C68C
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268504; cv=none; b=GgAKnKXtD2gbVqVw2xvuhaOkuML5Ls0F+glopNubM+RjIdkQt4iHveShcOgXiCrkTLCF8ulYRnEtvmxMjXF9oen8Q5AvjY5Ig61aHm5QqcWeJrkBWdxSV6hk0KnEisimpH4IMmxPdLT3pBiT1hSKNjHj4n6FiKPjOBhsunjpQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268504; c=relaxed/simple;
	bh=0H0gxVriWSCQOJEPo7GZ6e72NRKw4XTZoPmDiB6qP/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsWDfrBhgRZYVtJXFRKQn61cbWw0GfhehlyBBLrRRzHhVVC54yczlNy0Ksj9X1RdOXFdPVpVWT75G7mck5SJyVyMAAWaxQTR3Za+4iFyypHCTIRVj7wbnDXkvU53ctu8SCJTWarOLxUa+qB6JJchz/H0CkA4ZgC2+1HUHX3yfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fSxeKpvr; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f5064816edso44519531fa.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268500; x=1725873300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H0gxVriWSCQOJEPo7GZ6e72NRKw4XTZoPmDiB6qP/8=;
        b=fSxeKpvriLvr4A9U7zI9CNsQ2jqomNvgmH+hAshBvjH45lLoQ/MFaoGHkUcAAjkZwd
         6NH1wUTKyHe6KOBzSl61AK0TLE9oJN4OiVjJPzSZh5JU+JqZF/cYYtL+aNdudji0I+Xt
         7voTriq5QZGMj2vI/DyX/9g+fiSmTd0CtAm7R2sEjUYBLgc178v5OpZjmway7L/XssMG
         lzukCnRCM7OXcUg610aPbLj/chRr8aR+Ya5RYA50zXS3ef5f6lT1q3F5Bo4nWROTb2i1
         2lTjgHP0Aoicm9t7h53wcYJiDsjsJGwSMNcqZRLeh6XfcwC8n7KzGb43YlxEIsuTv6b6
         yVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268500; x=1725873300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H0gxVriWSCQOJEPo7GZ6e72NRKw4XTZoPmDiB6qP/8=;
        b=lv4055xicyEF4/w1ORprnHRRL+C7oFuSSuNp1jpI6WED08qgTnT9SVw+vr17bSIMGd
         gNePM2lsdE+u5yX3uNLuQdtDlkkmCf0GXilxsrhsgejFAVQ4EEgQLbPD+zyQBYSVoMm+
         rBfbQqyEnrQ0RiRYOME2aFqpk6k/uPJe6WR4N3eaw1nw7E//nv4AzshJnhSCqhpYy4kW
         SgtxqR/hxoySaYYnRmUqzTMejunLiMvrx64V4KvL4AXns5h2yHC2hCM4aABoUWcrIIAh
         ZWWOVPEcHZLu7TM6I3PzqOt85mFzCBlW6ZS1pXKqBqxzl7x9oqQxjhjBc/hcCukLEKx2
         RBjQ==
X-Gm-Message-State: AOJu0YxFbTZbjB8JTT9wVTfI+ORuyBrtewZfcXbhdwhg8HD4Mso1C+N5
	K4ke/Y36xx3TCiOA7pCZL4wdEB5knka2a4HWseNDGOrkVnu0QD3vTvyyywxsIV+mFCVkrq2Kmb0
	rzAeQCrWd0LJ7oYQ3q+WB2ZfNIQ3d4AUcuhhWAQ==
X-Google-Smtp-Source: AGHT+IFmGEhb3IlOYzMPzYhmc6prKWfYIZGiEuQHx9IyopscgCERS8FQV7Ug8XbLL6gltAOBNr78fvR1IRALEqz/7eU=
X-Received: by 2002:a05:651c:4ca:b0:2ef:2332:5e63 with SMTP id
 38308e7fff4ca-2f634f9f448mr25014561fa.23.1725268499825; Mon, 02 Sep 2024
 02:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901135950.797396-1-jic23@kernel.org> <20240901135950.797396-15-jic23@kernel.org>
In-Reply-To: <20240901135950.797396-15-jic23@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 11:14:48 +0200
Message-ID: <CACRpkdYMNKr0wC9f2WYbxJHxNGA91k2ud54obHEe_urGPCJ5-w@mail.gmail.com>
Subject: Re: [PATCH 14/15] iio: magn: ak8974: use irq_get_trigger_type()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Sean Nyekjaer <sean@geanix.com>, 
	Marek Vasut <marex@denx.de>, Denis Ciocca <denis.ciocca@st.com>, 
	Rui Miguel Silva <rui.silva@linaro.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 4:01=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

