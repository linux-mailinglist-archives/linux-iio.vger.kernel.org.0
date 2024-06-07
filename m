Return-Path: <linux-iio+bounces-5983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725D8FFF1B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D147D1F2A221
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DD15B143;
	Fri,  7 Jun 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1pduJNp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB215B139
	for <linux-iio@vger.kernel.org>; Fri,  7 Jun 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751969; cv=none; b=iKXmXTNnANJzt4uPPW29s5fgU5k0Wrf45DnoSo1SvBiGSa7uaop2s/krJgN05a0pUUypciTo3njiVGZN3Tloz6Q309n+DMRmDfTmAhKXYzh2NozsjuB3RDyy/hYy29n3q8CDEcb45XvrlswcENtUIaf3G+AxyKmUkJ8jzrL+tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751969; c=relaxed/simple;
	bh=V56qmirCFVXzJkhSirl8ym+WKZELaohL/SWX8q5xyA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuyPxP/gWiuSb8DfRneTocV/X9V5CRIWlVcn1i2T8GDlg7uB49S9K2LadwaZIzxpbHIwpwN9Z53OAuz2/z0tGwlAHBE8NxqZCJozXj3SrXtPloGIuepoIdK+/sGWlOAnPDYIAHQdVP6LEHd0yB+cim/pAmRgyWOH2QGmRDJ24cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1pduJNp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so2063066a12.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2024 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751965; x=1718356765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V56qmirCFVXzJkhSirl8ym+WKZELaohL/SWX8q5xyA0=;
        b=F1pduJNpMWgaw27O7LxSXvCRchT16p/RI6dSTop5pMkSw6YogngLx/Tvk3WTUlRQWr
         H5xm/ohCeM61Bk3f27qzNV9ushw+GpsPouMcxo+ZIBguPQaycP9dUSSPWFVcsXEvYjAp
         ujsi+XJO1vIzRwiyuGvVbROP2z7x020Ei6jCTx7+SQxm1lBmNsuN2kb0owUOSNaidQn3
         DozRnUjhqfCmHbpZglRviZRGgpR2td8iMNyZx21WGbfeZMUCDYIgkkECAZhdOr0Fn/8I
         HoIXxVlJMBMaNdgdWlLWFfGmPLKIm5JxVZdFkBCb1A1ljcy6AGsRxsd5BghWl/amM9rx
         kAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751965; x=1718356765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V56qmirCFVXzJkhSirl8ym+WKZELaohL/SWX8q5xyA0=;
        b=FQBeZFRvzb7+5Q3fDkekZZ/ZSMSzTDdeyDGI6kkY/QihBYfjszjNOPi35gdzj5iB5F
         jOtxSd/VXCtdsrk0dFvxR3ahe6jOn7rTdKx+LqCVYZ+QRf0PJg+DG9evVLJEv2gM6CQU
         zzB825FiJ5EKnLq0I5qV2zEyQnLky00OntUMcPDZYbxMBqILnKT195eD9Otujm0Xp7t8
         shO7G2+64jHggYpvV4cnCp2AbwzAq037OmheHLTzIGBAAZXkcSZQSIclu3FpGMMzbxfV
         pIT7a4tWNwABywzTi8VfWiBzTBfgAX0hHNQHrFwuU6Fx8n5TJEEX4l30g+7c1flgqRCo
         pblg==
X-Forwarded-Encrypted: i=1; AJvYcCXw9KGvyQF8fpl9Ddnkrekhz0pgafKBnlNBpxfoz4vvDnH7CR6cZBhCHbbCE3oD81XOMroWh+Hu+bsoJdBgiJevREtra9OgzgzY
X-Gm-Message-State: AOJu0Yz/LmGb0apnW955kDQ8XZTcM9hD4oQg6BI3fYtBGWmJeUDoP3mE
	e+wbgSB1FltAflCAM8y8sHHXJKN3+5BNrIK/m3gAXZyOZPwRcw5m
X-Google-Smtp-Source: AGHT+IE5eH3XAjqumOHvbveY5vCe4FKDD0C2xPaYWsV28+Mwai79w3ytVk7FDDsoYpsteWi9vuyvKQ==
X-Received: by 2002:a50:bb66:0:b0:57c:600b:b64e with SMTP id 4fb4d7f45d1cf-57c600bb6bemr264703a12.27.1717751964949;
        Fri, 07 Jun 2024 02:19:24 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c5fd78477sm265913a12.40.2024.06.07.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:19:24 -0700 (PDT)
Message-ID: <89675b5391c3c37a69654f0cd4ffd0e2ea312056.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>, Jonathan
 Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Date: Fri, 07 Jun 2024 11:23:12 +0200
In-Reply-To: <20240606155407.499344-1-u.kleine-koenig@baylibre.com>
References: <20240606155407.499344-1-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 17:54 +0200, Uwe Kleine-K=C3=B6nig wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

- Nuno S=C3=A1



