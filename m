Return-Path: <linux-iio+bounces-3148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5EE86A99D
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51F828B72C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416FF286BD;
	Wed, 28 Feb 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="FA5njx6a";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="jt+ZOopt"
X-Original-To: linux-iio@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4425625
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107937; cv=none; b=i0wRO8Uht1CGKKmDcGKCYOZwg9cKqRw1d8CTdxJNptp6LaygQhlWYUJ5lNmlzR93QEwjGmyr3ji4hXibBzUY+KKwFVukX4CaPv8qmmDBPKNO5ju48bnLQKdFqaXK0OwlgyQ+JUHSXmhjBUURXu5OVr6R5Qhq+/kEcSOHcA3cCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107937; c=relaxed/simple;
	bh=jg+SisA/AOLTpSAWQoZn0j7lDt00VMkoE7oP+xvQUpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWfMFkz3QirjFONo70hJiEDVvKsdry2Z7p340wBgN8eW+lYNKE8j0QgddrjmCRw6giBy658KERPUYoq94gNNUbZOwMF0kvLnsbWOOgQVgHq8t+CbwlN+qcZXUs7QOCRLIQ1jFGqRn/uOxCeBiquZ30V6YGAyIcNOaDv/zM8HFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=FA5njx6a; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=jt+ZOopt; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1709107934;
	bh=jg+SisA/AOLTpSAWQoZn0j7lDt00VMkoE7oP+xvQUpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FA5njx6aFMYMtI1MXRV4ETrhyJHwhTLhXBD33H1MFpUNHHRFj0DkA/IUndht0AxmV
	 Dk0ZBMQYlX4hHGd+dr0KHhSNnlo6SMnTOXBofXo5x48Kp93sdNuDfN4JWmz1NtVK7b
	 d2h/tpYVLw4t9Nr6dvIDz6ZAr9OTLORSx7zYYYs6ssRpe4oax6QV+C3QJeuVynthqP
	 pMV7vFOQE1ub8Id8avA+V/DVirz7oING7YiXh2zUfp6oMfuTLzJoEtXbuG2yofurYl
	 UhbRcdxZFwVXiFxrf/u88k862fMggBoVaSi4P6mqiUWNmp2GOUEMSxyKUQYORHrGA7
	 e/BggwdYJe20g==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 9DEFCB88
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 17:12:14 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=jt+ZOopt;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 40081B87
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 17:12:13 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d542680c9cso61745855ad.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 00:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1709107932; x=1709712732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vA7tB+7PRAOKuOpgMeI08u1IIEyAtOz4wiPVqsH7x+k=;
        b=jt+ZOoptVIMx2DEYmJX/DIy6/V+J767vxh/yXVgo5FI/xCwpxzjhN1shZJLMuLU9ID
         5JyzDK2jr4LPExUDHs3l37S6M+zd/21sgX4Ov2zthvPm9MYEnWbvML6MQqzXX17ogBVh
         l2by2SvvFVzdel+wefZxezClRpXJ4sfdNbBjmdMWoI66qp7STOjiPkcUB9E6qgC/ZwuK
         oG3n32udEMdmv6MPjjMjQWo2oo3cWdkl/3J1OczpBiCEQpVMn3UmlyG2MwVAqp1brS3k
         1NomjEVshGNF7eVMEw+PR+6Wq8liKBFipjcKVvKMIb2Ud8l5ja0KfcqEzEtWQFcD9Dr7
         97cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107932; x=1709712732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA7tB+7PRAOKuOpgMeI08u1IIEyAtOz4wiPVqsH7x+k=;
        b=bcdSGfobAeSaRRk5hMdKCPJw3uFon8lGXt63afUTKck+OWLwotXINAptdPTpwbIwKx
         hl5Z6vMrmWD6Zf/01J30pGBgVSp9sIT78YKJqIpphoiEJ8IpK9dJpLztbzhrIBzoKRtd
         X5m2Yfzh5bBGNBrN9r+RsrAD3jL9l4/MbdICX8+h1u/1avIhZlEcqfjS+4K/7KgFBrlP
         5+u49E5QxVO/topYIr8ckTE4Qiuvq554IBjVQD2HYpd5uGzn4+UH25kHYO7ORZ5iDH1y
         CrwqxcV7Fd88XhrXF5Kt/M9Ze9jShdyjHF+aVPYUklH8IMWYzpnIwRCjY1jWojhBHo8u
         WrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUflte4NQCkJICS0kr5thtqvw5fd0E2LfncMc2hd//7GkzRKyLgv1XDn48husZhr5v0evfWPrnUejFfmf0X7zc5kbdzJurb1v6H
X-Gm-Message-State: AOJu0YzSf52DiS6VnutCs1QYcLNrSKvRCaf30YNX6t5g1yFINvDJcjVy
	E3xTKMj3//Wnq696nu80OnqJ/lRn5a9YHff7iJZsgf4WkbG7FAw5Hlvu5FaDfg6XmTfjXmDw5mH
	wldgqlGIAxTeiCpSgffW5h8s7Dsh2j+w8SX4wwIyFShdh2BBqFKosEzHNFe8=
X-Received: by 2002:a17:902:f551:b0:1db:e74b:5bbf with SMTP id h17-20020a170902f55100b001dbe74b5bbfmr14270255plf.0.1709107932287;
        Wed, 28 Feb 2024 00:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1SaibCEEwe+85FcT3ZgC2jwk6hxt7zWIfC6YXOT5mGsGd8kmTKdnW/ER0TOkkSZx4czXt8A==
X-Received: by 2002:a17:902:f551:b0:1db:e74b:5bbf with SMTP id h17-20020a170902f55100b001dbe74b5bbfmr14270236plf.0.1709107931914;
        Wed, 28 Feb 2024 00:12:11 -0800 (PST)
Received: from pc-0182.atmarktech (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001dcc138d4afsm1907072pll.34.2024.02.28.00.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:12:11 -0800 (PST)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rfF2v-00GtLX-2n;
	Wed, 28 Feb 2024 17:12:09 +0900
Date: Wed, 28 Feb 2024 17:11:59 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <Zd7qz1Qte8HWieF_@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
 <Zd7hSOw3_zosyrn3@atmark-techno.com>
 <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>

Krzysztof Kozlowski wrote on Wed, Feb 28, 2024 at 08:42:46AM +0100:
> >> Sorry, that's why you have labels and compatibles.
>
> > Setting up a fixed alias seems to be precisely what aliases are about
> > (e.g. setting rtc0 will make a specific node become /dev/rtc0, same with
> > ethernet0, gpio, i2c, mmc, serial...), I'm not sure I agree a new label
> > would be more appropriate here, but perhaps I'm missing some context?
> 
> Maybe I don't get your point, but your email said "sysfs", so why do you
> refer to /dev?

I wrote /dev/rtc0, but it also sets the name in /sys, right?
For example /sys/class/rtc/rtc0

As far as I'm aware iio also creates character devices in /dev with the
same name (/dev/iio/iio:deviceX), but our application doesn't use these
at all and has to? look in /sys directly, so normal udev SYMLINK+=
unfortunately isn't applicable or I wouldn't be bothering with all
this..

> > I'm not sure I understand this comment -- would you rather this doesn't
> > use aliases but instead add a new label (e.g. `iio,index = <10>` or
> > whatever) to the iio node itself?
> 
> No, the devices already have label property.

Thank you for pointing me at the 'label' property, looking at other
subsystems e.g. leds I see paths in sysfs that use labels as I'd like it
to work for iio (/sys/class/leds/<label> and
/sys/devices/platform/<parent>/leds/<label>)

Unfortunately for iio it looks like labels isn't ignored, but instead
create a file in the sysfs directory of the device, e.g. I now have
/sys/bus/iio/devices/iio:device1/label which contains the label string,
so I'm not sure that can be changed easily as that'd be a change of API
for existing users for labels in iio devices?

(I checked briefly and didn't find any, but there seems to be an awful
lot of code in the iio drivers tree about labels so I'm not really
comfortable changing that without some more background on iio first...
Jonathan perhaps has an opinion on this?)


Thanks,
-- 
Dominique



