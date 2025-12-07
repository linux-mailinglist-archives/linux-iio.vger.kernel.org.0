Return-Path: <linux-iio+bounces-26899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A910FCAB71D
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE8193000B7F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A471273D6D;
	Sun,  7 Dec 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2wbkJtv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0823B604
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123195; cv=none; b=f5C2HwCUP+wA6B99oSpn0pPrNc1NevYHDmHsru8H3vHJtxL3bWKrEJUci3wGwgUw73XH6QqPFN5+h/ptQofuhD1EV+sJvJhTByoevfa6y8/zWgygw8y9zgQDLE6EDUlVjU/8WJrMCYAUSsb+IpgOPxjTrA7PwwI8XgPM6rZUDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123195; c=relaxed/simple;
	bh=lN2nyMT5KURr5BnJaibgIHzRgf7UPdc+YsOVRYAzzEs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=s+8D6bY9IJU2z11S2Wjwgr82ypgU60haJYCAp/m9qUHXpVbAuP+19W7KsE8/YypIy33HYEeDDaVGOZL7xqmwvw/6IV4vDTGSCxcomEIGUXwEpn3eneKh/excOGWJxuvJ8x3v5EkPGz+2T8CY4C5b77VsiEX8cxNgYTPkmQhEptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2wbkJtv; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55b6a642a4cso2611155e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123193; x=1765727993; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN2nyMT5KURr5BnJaibgIHzRgf7UPdc+YsOVRYAzzEs=;
        b=B2wbkJtv5/I3xKcPY7+hZZjjt0igG9KmUzrYhQYhRG5wvmmGvvPv1OstvOxwOKfY0L
         X5F7Mmz4/5LZQWL5GenxEgxk4oiV/WBfalzObMOLx4aEYgZRv7YKBT9YNXrySbtY7SDE
         LW6O8XArIKe0jvRW0zapvYfI0SYNOMN39Iw8G1j3dGbWe/C5EO136fzSUOVxBjn4YE3L
         0OHOi35jy0aS9idN5GXcOEaA4TLcrkPwypR2uU24MIsLf76oxheIi+xxi7lsJetOFjQd
         IqxtHVJ0m+FYzGWUxSrpNfRdcmparUXSeYHXCYxplPukyWfcNY9utthBdCKvQomW+fGN
         fHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123193; x=1765727993;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lN2nyMT5KURr5BnJaibgIHzRgf7UPdc+YsOVRYAzzEs=;
        b=TQMpt15W9Ue0QT8q9Lm+amGx51muVHracHvYgG7dZCyyRjpcDgGOA1q1Wv+vZn2aP6
         /pirGNmS0UnGkjQj80wQoDR1jOFwb6spg0oQew1Rq0Avky3tBtdwtwWjyhuVxVHsAJ5w
         gta3t248iI8zjGC6Dz3VVQc2iaIb+4iNDpk7zWbPCN6e8qm/TN1XGIx1uwQAAY6AmnHg
         rd5txATiSp+KFm/CMtMbOyPmr0Gvn2Q9pwUQTT3yuWaXSmbP6oK8WTjEuLDAhOcFFxPR
         XcgXVFUm8/Ncpsp7FXsFN+6i8auu2sFHck8dMPd+Sq+aZommK2gj5ItHpWQqjRw93QDd
         f3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa6741fRrfXrbKUaRSXb8LxNJSX2J4kiXll3tBh52v4W4PGqIYc94snyqVQXqjumGchZ1lxGlYhLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkB4HBExk50x2JQXDFa7FuzGR6tc+9BgqBi/CpSB9doJFx7t6
	dbZvQGzxXDHp7Kkd7YtH+SBN0uiUbAV7C2MbFQO0X4UetAz2gMOZJNCa
X-Gm-Gg: ASbGncub0CBp0tbl3O0bjbfS7mVFTsiDKW1p6JMcI993lpX1opeFt3Be0ndv/86f/66
	U0UkbvrvxNCo4gLbDjhsZ959d4hoZ1lx2YHKtU8oANynzTuf2oElBSrtp94Kllmq+xujG8zzmKM
	Ui0ZsGPy1OrerQLy0Qvf29aKT5pdwGZbaEEFTU5J6c8Tvqovpffcnqlw3UQ7izM1UDJJv60RCzO
	8f1oVE/46oXGoSltDwpKlc9VRL8RpOaz0bdRMopiLRkwyWUf7ILvlYDJY46G2Lc+TTg/SvpFH0/
	DJgxko1mQEXqycFL0FvgJN8CxLd40b43NUODTRop6jv39fazBxlUtYLSkCs0j52gqOIQ+CH1rJ0
	am9tWnP/mLclQqKCrnHUFOv89M7ctpId/yWDJ1yuu6vCFMzKd8eigF0GtNDjV2WcUquq+Cbhkoe
	/eZkA=
X-Google-Smtp-Source: AGHT+IHb5qCj47GPIJks5IrPfFovkp1AcVzoXUqVEm5uXUvz/i0JGsqz6kwhm3CHmygeESKzo+fSKw==
X-Received: by 2002:a05:6122:330a:b0:554:b32c:6f76 with SMTP id 71dfb90a1353d-55e846e664dmr1336197e0c.15.1765123192735;
        Sun, 07 Dec 2025 07:59:52 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c568ae2sm4895821e0c.5.2025.12.07.07.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 07:59:52 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 10:59:50 -0500
Message-Id: <DES3Y754XVT8.1KUU58F8LQUHA@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
 <20251206182057.40402e66@jic23-huawei>
In-Reply-To: <20251206182057.40402e66@jic23-huawei>

On Sat Dec 6, 2025 at 1:20 PM -05, Jonathan Cameron wrote:
> On Wed, 03 Dec 2025 14:18:17 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Add guard() and ACQUIRE() support for iio_device_claim_*() lock.
>>=20
>> This involves exporting iio_device_{claim, release}() wrappers to define
>> a general GUARD class, and then defining the _direct and _buffer
>> conditional ones.
>>=20
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> I'd like some documentation (alongside the DEFINE_GUARD() stuff)
> - particularly warn people that using the non conditional variant
> is very much the unusual one.
>
> Perhaps add examples of usage for the other two and ignore that one
> on basis alarm bells will ring whenever we see it in code.

Sure! I'll add it.

>
> Jonathan

--=20
 ~ Kurt


