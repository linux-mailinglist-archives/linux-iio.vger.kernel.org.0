Return-Path: <linux-iio+bounces-2778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CA85A51D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B31280FA6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F8364C6;
	Mon, 19 Feb 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqDPMDDn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAD364AB;
	Mon, 19 Feb 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350574; cv=none; b=TM9nOxhP7M+Sut0Mna15SZITJnOBl199r4ZqPlyN06oXFMWZhyzAFpkYwqdOC9GaFtM9XNMTLONGLlLCbfv+ZLi3HN1jmVtMA/N32Y1bIQVIQfdKsF0PHU8Ug0afGI+OfDv3Ztj3SE/heFOL+8v/ApzMVF6v7FfrWUVueG5g46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350574; c=relaxed/simple;
	bh=Vepvow5IP36EYQgqomXlW0S/iEJkhD2gJC9C6aFLKvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eid5ggvKjPLvFPnrgHouG6ZHOFMXpzIp0IB4Mm+9MwgUnDmUiJtbyrS6iC/BBfdZzX7tfcuabQOdBnIdYNzqFahYPrvAreuplOEJ9mAlX8Z8zBtLYQZCrytLNrYOJVaZ98ni/ycMhfHLz93x53kWEQE/lD3IGE2lfPvKqCzP8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqDPMDDn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4191902a12.3;
        Mon, 19 Feb 2024 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350571; x=1708955371; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vepvow5IP36EYQgqomXlW0S/iEJkhD2gJC9C6aFLKvw=;
        b=FqDPMDDn0Rt0hyVuiModmtJYjbqAorHZVhZ+TYaDYPfebTvfnLPKl+k4RwA7lksT52
         EpuHrM4UZ6ywHAePwyYrsv1h9XsEdQlqKubWfI69On/lEG6s5t3Mq1/0mV+A2jNUa2LJ
         ufarLIDsA0nlYvZT0m+8xLp4GLx+V+SnVKSsLJ3UnU1dtoa/VuKcNBkE2GTZU4GRjN1p
         50wlYlNco5y1+KEFBxXT1qAjbHyrLWy5KDVILcakUAkg3MPSKmy93F8UGnBiLebu1h7z
         xBTZorFDczf/C4XJbnB/9yw59pR+cJZG7y2i/c1lY+Btk+6umYOoSe3JEHAuje5U53Su
         n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350571; x=1708955371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vepvow5IP36EYQgqomXlW0S/iEJkhD2gJC9C6aFLKvw=;
        b=EKl6B53cgn2Oz4dZ8s+ly7diMVeLtB39/JYE9OmvwvW28YQiHcASlIpOhrQWM6mKYn
         0L1C7d29XbrvDt5QHH3usM7SeV79s1M4o0hYaT3/U7DtWMy6CupcK6sB6YmQhTXtNwmB
         wOksA2FwxMDS8AWykZF0I9KqlztacVfYILCJKpuC/OAQeWKrCroUJ1cDB/GjFLCMis8Q
         SVsNeNjs6euSIp1cSwVZAj3n5dk6w2Ta1ULO0gL10a8pIlwjF3BRt+qBgJ868N2cq5+x
         DUjnUSjY1eIJ81JNgp8qN5i19nNWeOF0sNtmtEjVwAWyZtx9nhwrD3zMPxI7PgY5oewd
         ItEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpkHZaGS99TYAw26QpCKrCUSQNLEu5BatXp5sY4IDop8d3nPIiLsUIDYQsEuvUjNoFBPuSUDQ1YFbWPhiUfPgYmOmFZKs0ghCRWJUtfvTFVDjXjQx/hrH1HREV+t067R90ATOf6A==
X-Gm-Message-State: AOJu0YyhfNuMbTD6EAcGLjUQICYZ40wZ6kbR64lQ9rEoKklpGTdRr19q
	o4rbdlWcWcWv1jlouWbEeOgsBOtcFVVJwgOEsBsek0T736f0J106
X-Google-Smtp-Source: AGHT+IEwEHE+CvD5IHptRuKFyUBL3kO/rc/8V5IwE6pRj2cUI8AEdhkz5kUT85X9uhiufDG2Mrd7Og==
X-Received: by 2002:aa7:cf8d:0:b0:564:6756:277 with SMTP id z13-20020aa7cf8d000000b0056467560277mr2123613edx.6.1708350570576;
        Mon, 19 Feb 2024 05:49:30 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id fe4-20020a056402390400b005647dfe9815sm832120edb.8.2024.02.19.05.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:49:30 -0800 (PST)
Message-ID: <611bf0695d497219d85390d200417596086435ed.camel@gmail.com>
Subject: Re: [PATCH v4 03/15] iio: temp: ltc2983: Use __free(fwnode_handle)
 to replace fwnode_handle_put() calls
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>,  Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 14:52:51 +0100
In-Reply-To: <20240217164249.921878-4-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
	 <20240217164249.921878-4-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-17 at 16:42 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This use of the new cleanup.h scope based freeing infrastructure allows
> us to exit directly from error conditions and in the good path with
> the reference obtained from fwnode_find_reference() (which may be an erro=
r
> pointer) automatically released.
>=20
> Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Move the declarations down to where they are assigned.
> This both clearly associates the cleanup with the action that it
> is cleaning up and avoid potential future missordering of cleanup.
> ---

This LGTM. Only comment is that in ltc2983_parse_dt() we do have a loop whe=
re we
could make use of device_for_each_child_node_scoped(). It seems to me that
change could be included in this patch.

- Nuno S=C3=A1



