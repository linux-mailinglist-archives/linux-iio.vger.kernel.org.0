Return-Path: <linux-iio+bounces-21852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBFB0D0B0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 05:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89112165F7D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5C28AAEA;
	Tue, 22 Jul 2025 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwwGWnNk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB35223;
	Tue, 22 Jul 2025 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156520; cv=none; b=NpA4WfvBD3Y4pAd2ZqLnAzYbqWHiDNsP+qAWLTRtk/jzLtJDnx7MZWuXmMuUmnx6wNshnet07f595HHYKcR7o7opUMJpRMmNDYuoQ+2pE3shbyfqKdc/OykqMwiPytJKeZS3/Vg1AO2Jq6MCVKbx0voEw0XIaJ+dQN5tJbW4Ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156520; c=relaxed/simple;
	bh=uLfI0JdQxtNSl4dFDlXZIYKwg2EUg7kNLzBl+vl1h8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC1gQEPhxv0rACytqwy1PH/Zo9WjW5VO5gFkLfa3l0qJvjr2+CygqweeopSdPr+6n1lPJjRpdqk+kxeKilj7Xipyd5CSRnot5BHg96V+CsupdW2VaYrq92jY2HTeTJmaPEe/97LvH9BcFKjgVDXRb3yRReil63lBpKVIlGiGPfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwwGWnNk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b31afa781so39662851fa.3;
        Mon, 21 Jul 2025 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156516; x=1753761316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qYa8mLH7rDMD8Oz20MA0QmEr0Exb8HL03mKYAlm/SA=;
        b=VwwGWnNkd9jqGVa7M+WNp3Jtylaxaw/DNxVWMDVH78J23jEY1ZXtUPN36uwqOtO6On
         l/KRg6BKMQ9duSVsJnJRobBHUtC5uUP0uyTsZ8bZ7dCUQ3vj9pItycBmPYCaV2ued1Qc
         K9nNfFPZo04348WH2ZtTEsXpn1nUmmIYs3n1s2WW2Cj2w9UmkAJAu2AmRzHYCa2UGacJ
         fDU0xQkEdGzZ6rDBDfBojwrTNAotqO6HsltgiRSzgrEjPHGtTjGiHj9zGigp45e9bIM0
         Kdxws2XhcyqTI7ifKdovJDWBcUgmNDt88wYrzjvulj6fCyJRwvWWO5G+hfACQllG35n8
         nPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156516; x=1753761316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qYa8mLH7rDMD8Oz20MA0QmEr0Exb8HL03mKYAlm/SA=;
        b=wY7zY33vZPmqfE1ithEnIwE+9aQl68UootDkF+2hA1w4ud/tbJrJitHKCTWWAC5IY4
         owjKIUC9gcAUE1aii0uC+7h/rG8SG3amxdoqcBRZOr7QjYRnw/osEByTHRl33CZ3BxFO
         ld76GC4sxRl8Va9MaYdp+A9Lq2i8CJRJAuhXMinv28f8e2UyKyYFtyPOyFB+Iel08QPH
         I0KltzuvFdHq5lNHrWDMMvD1XfHcvK7NcZuM1umUp7UMg4r2y/7jpLa83RPWgDm+vbYo
         pNDCty3WDPeNnXtHFXtX+WPdKSSRcUgPqd3XyG+qM9QE8pvGYJLNARyRUs0164PjFCpZ
         paaw==
X-Forwarded-Encrypted: i=1; AJvYcCWO0Z91xF7Y6uW3wqhNzuxawBCwzvECqJBzCwDmGQRTRrOmUc4uHIK12DRKbBXevdXhGWNka5swZzdPsxHx@vger.kernel.org, AJvYcCX+vkieS45663gaenFLt+hdSzuIRAnPobsmcnCkN9WacWRB5goGDCXJJBOXBbLZzrrqHX1caTRbpew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYd8PaMKnY35dUc5ciEQsGQ/fUsfrxr7f+qY6Tbd6/9msMG5x
	qd590xduN71fLm2nx2tDAaZLv40njWOhK/bhUvZzNJgEiZ0E3QEoSUktmSbSOBdASp/TT12cP38
	Na3zJ9q3K5wR90vkD5hUf0ODSmpYIvyZqOaFS
X-Gm-Gg: ASbGnctzo/VZgPW4OgZsQFhFTWNAFcblDDF3Hd3s+DJa/o6CseRDJUT1bYh8k52qImX
	M6qHSh+Ls1WIz+bSZ3ZQaH3MrGUzZ7CwhOYoNMA8CwrMAZdqn3pbxQsa3HURK9b0oW3ZuKVY9tN
	4sAjl1XjZbCOD9Sm7ky3tMmXutDjjemn47bl2s9poL9Um3WpLyPwsjNmYpArz/ap/uMMDZ0CESt
	8c2U93Ow3ir7zX2PYCNf9rjdScfLf3WcuACB+SMeg==
X-Google-Smtp-Source: AGHT+IFG3grN5CXSu4ye5TD0PuqXwFECq2wqrMA2A0V3dbWck7PI8idYAn60Mv+QvrontLo7RKveT4mmWeFARTCFoXU=
X-Received: by 2002:a05:651c:220d:b0:32b:4521:73cf with SMTP id
 38308e7fff4ca-3308f4c38e6mr64872831fa.2.1753156515844; Mon, 21 Jul 2025
 20:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com> <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
In-Reply-To: <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 22 Jul 2025 09:25:02 +0530
X-Gm-Features: Ac12FXx1WJOmzkBIaDREcUL_9375l_OH-2EpTkgK9yrcGJ3fmlkoI2YIP4ZoDKU
Message-ID: <CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
To: David Lechner <dlechner@baylibre.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks David for the swift and valuable feedback. Please find replies inlin=
e.

On Tue, Jul 22, 2025 at 1:55=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> For debugging, using debugfs would make more sense.
Will it make sense if I simply give register access via debugfs?
Something like this:
static const struct iio_info ad7606_info_sw_mode =3D {
    .read_raw =3D &ad7606_read_raw,
    .write_raw =3D &ad7606_write_raw,
    .debugfs_reg_access =3D &ad7606_reg_access,<---------
    .validate_trigger =3D &ad7606_validate_trigger,
    .update_scan_mode =3D &ad7606_update_scan_mode,
};
This way the information about data status will be available on demand,
without exposing any special sysfs attribute.
>
> For application level filtering, why does it matter if we have
> read the same value before or not? The sampling_frequency is
> available, so the application should be able to deduce when
> fresh data should be available based on time.
Agreed.
>
> I could see maybe polling this in the kernel in order to implement
> a buffered capture mode, but not sure passing this on to userspace
> is the best way to go about it.
I had sent 2 patches. This was my PATCH 1 of 2. In patch 2 of 2,
I have done something similar to what you mentioned, not exactly polling,
but reading the data status bit before reading actual data.
Both patches are independent. Please have a look at that as well.

Thanks,
Akshay

