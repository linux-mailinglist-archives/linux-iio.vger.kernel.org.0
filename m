Return-Path: <linux-iio+bounces-19381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0293AB13A1
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77D71BC3FAA
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF55F290D87;
	Fri,  9 May 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HErkqrQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C92900A1
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794442; cv=none; b=kR7Muzx2/pIFn9H76k1DvHxC7J9erWHlvGB3ekVBqww9cuO/ZTC+vZdWO3KX+Mk9Kpk7xOtF/9ovO085cfauYT5KM+Fm7FwJmYphhwIqnxhI6pgIs41/CDGjr2KWEwUiMN084M6cI0QBV+zIDdJhMKHTUMaFa9mYR6VdDX9TwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794442; c=relaxed/simple;
	bh=+UtFR7vubZW89xp2cp1g2Mh8plnjtSualam5Fk+kOWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnprBKdfVycdDNVK6HZjry1ISCitfSBAA04b0LqiGamecOLU9MJvo5gqBSTxXaxIdscwAdioAgJq+GVMAdF8e3oslAHLQQnfqbR61IfEYf0fZQjMyMGk/N3uY4H2F/VP1Op0nZtbTBbOFY9njkmj4IVGvV9wrsjUMebeTUbJW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HErkqrQK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54fc36323c5so1481652e87.0
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1746794438; x=1747399238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UtFR7vubZW89xp2cp1g2Mh8plnjtSualam5Fk+kOWg=;
        b=HErkqrQKP7FZMBiFA+4j9WWBFxcxkh8MUw9fWEDg4mqJ2mZA2VZXSJWoB5YmiwOA7Z
         N5hM/605MxsGhaISDtMG8hl7Vord3C7rB/ewJCRgr1Zs1XjrJyLPBxaTUFkYTJ1pbt49
         3H5HusgBUCpvD80Bt4j7zddk27RFNCdkAHfXYx/C+5yZ78w+2Di7EIeNknj8ev9w7L9x
         GHZgUP37AfgPds0nC57fXCAc6vSYgHrmbNPFVYTs/AHjkP3lQwk7+ZCj0grOgv8egR37
         5A1R6vVUif4PA5p/Q8SddLfiFjHrw3azQTx3VEA3a8r5mwkC7+6IvotmWS5fiMwRcGkA
         L4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746794438; x=1747399238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UtFR7vubZW89xp2cp1g2Mh8plnjtSualam5Fk+kOWg=;
        b=sxv8deKQ1z1X+wbrvwJH+L2MVFnRtokkQVovsRw6StR4p/X6UuTVa8B7kXKUQeUY77
         hq+Jf8aKHZMGfFG1J/c1Sym7baq+BliQPIlWBmUdrkmETrVVVgKdWtKt7X2T63b7ybDp
         NoMOGYbxv13ON9+WqltTJIMpElv8PEUqwnp6n7AkXd95Sh+0kNoWrMmdpVDadGR2gxas
         zo5urBJFnEowDbkZqzDjTXbt2rw2OP/Dbbq6QtXzCcxwQag+6idvCur0zUgXwiJn3lb7
         1mBB11u+jqtOld2A5QaO294ZYxmeApgW/MgxHWcvowS7KkgdcxAKeCrD610mIICbjTK2
         u9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWjYsplWmCTnC1FeAzlwDpSZy4urD4sa5xhDUj0PuBD+HaMaOWzikqO1nNH66i6eqXcuflIgd+LbKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsOqQKui2AJK+t5z1m7gN8XduHy0xqGrYxRqKgQAH6QBnBPEe
	NKGaVQ7dZ85fTqTqoGm6pABEDVFTjh0sy18uS//T6ehA/b1uk9K9eqXyA4ygWdXkRaNnmRluu76
	OZ/Au9eZlb6nAOm1mTlFE/cHoojCXcgR3sCXzfA==
X-Gm-Gg: ASbGncvOk8rF1Aznzi9Yp2WXNcyYMHm0EZ+m6P6QXz6xouie6Ol+GkULRYi3JmJl1HU
	9exNQSjufod3hWl/rEF/cw4JA2ZIpglAYdX63e7tL2OyHZOFGFb+VxGk5CR/allCV9cr6AuHV7t
	zKbf8uUvYHbxg6jK5rqW++e+EZB6HRyIDz9FXBtpIjQYOLsoh1mO3Pvw==
X-Google-Smtp-Source: AGHT+IFdaNoxSwXadZPcFSu3s1a5OECzl0nPHiRim09tz00SJAtaxjhMC0Ms7Db/M0w/VxGQVS1tNGzED+Wljh/WZKI=
X-Received: by 2002:a05:6512:695:b0:549:8b4d:bd47 with SMTP id
 2adb3069b0e04-54fbe407821mr2923115e87.9.1746794438053; Fri, 09 May 2025
 05:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508130612.82270-1-markus.burri@mt.com> <20250508130612.82270-5-markus.burri@mt.com>
In-Reply-To: <20250508130612.82270-5-markus.burri@mt.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 9 May 2025 14:40:26 +0200
X-Gm-Features: ATxdqUE7pXlfCMv5H1Kgd5pteF0BctNTVcpk-CgS0AiKblrCPf4IDIEcE-yR17c
Message-ID: <CAMRc=MeYYUc=FKJdArpqv0D2fUt1vyCJiZzjYyN95aMv0-b1WA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] gpio: fix potential out-of-bound write
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
	Maciej Falkowski <maciej.falkowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linuxppc-dev@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, Markus Burri <markus.burri@bbv.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:07=E2=80=AFPM Markus Burri <markus.burri@mt.com> w=
rote:
>
> Check that the input size does not exceed the buffer size.
> If a caller write more characters, count is truncated to the max availabl=
e
> space in "simple_write_to_buffer".
> Write a zero termination afterwards.
>
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---

Looks good and does fix an issue that can be easily reproduced with
KASAN enabled. Please fix the issues reported by the build bot and
resend (as a patch separate from the rest of this series). Thanks.

Bartosz

