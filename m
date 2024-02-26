Return-Path: <linux-iio+bounces-3080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E64866E9A
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF491F25CEB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7151CAAF;
	Mon, 26 Feb 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht7Azpb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7F1CD01
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937590; cv=none; b=MsXa2uv3eBp3sYpAo78uJWQARo0gEi7svV9d5qYLZ/5F3b4TUHJYYw/cmxNiQB1IVHWkYlrOxT6x5zvH77rjye6UZu6UR025As78kPjvTCxwPCCo08+eO3TS1EY8CDC3F6LaLEmv4106g5Bzd80SlJ5e9Jd+WYFamnf2hqr8T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937590; c=relaxed/simple;
	bh=lOfDw7Dlnfp4PijNFIMDTZOLT3LcWHyKYLMDFWOJxJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jj2BgAeAOuZammlqUvd3vS16TQ3tsioYldNY4CIBCSCZubqMhfGso8Mu/J/7BHdQFvOVF81O2+R+tbnC6OQJb/S8iy6ieK/EhjjqzMRm4H8vJDCj8B567p0/TDqo+NZLD3btvUgDnY2PDok3kpH2XPk0BQGQ0JkujS7+PElG8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht7Azpb5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so1757438a12.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937587; x=1709542387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HrSwtSqa2R1jenHhK76d9gf9zm69QbGqgFHwGsU31p4=;
        b=ht7Azpb5RceNSuPSNyQe/D5Dvk/TSUlk76KboRPRIF8yMv1d4PT/Z0P8zEAfg4Z7ax
         bdPQI9iJU/kJkFNpzs0cnbM3yVGQ5jq+TUqxG1G5UtvFZOyplKFDG9Y/5NLbHHzuaPnh
         0sPIMCEaiZD4WIeRDcKe2vYCg/8Sl/kOc+GVI/dj2eVb2e3zUoUKOYEzgp5XZbZm8XHk
         1/ReIpRb6SzAiTYLlPLUY7pLSUogdSfvd7l6ENH9AoA9dMFnHA/ZbTJp47+Pl/7mIVSA
         SO5xclQ1g49ZSsNaX+BErqN6HxePZq5V8YRGhJVCIOWlxdHINq485CX+MwetkhQR0CTQ
         HC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937587; x=1709542387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrSwtSqa2R1jenHhK76d9gf9zm69QbGqgFHwGsU31p4=;
        b=ca9COA/xyMzZ4De43vLIVUkAP9g9EUV+K3CsmooEko1R+r0XE/eoWloNs9Z6ECjzY1
         UR875BSBdgwhqZyacButYIqDe66u7fDaA3Lg2i2KrLNorzL0TdW/wIuTQ3VQorIdScn/
         TteLRCIN/VcPiLuW7SvXLWDDs7Jy5ELONhiws+jLO4dOgqRx+nGjnSVA8l8DyURSAiBp
         +RbQwUhtWPiA9RQf9H2cn7y9oOF8ys1/5KH1UdKPq+ptg/zn+d4BVd1zNnHOABVtJOFa
         pGSFraCXIQ7kktcWZDo4xkfRyg6kF9tUKuqtEPBUQHNTUluEqO/+2RxKyd11X+H+fuoK
         Rn1w==
X-Gm-Message-State: AOJu0YyMwEnWZ7MBt+/i8K7QdK6PYJtOlmZHMKbnueUjb8rDsrapal9x
	FevSpHNUzEk4KUMl1Q25sv5K/+qrdtW4ba8eb8HC93RARHLYdwaClfQZSJu3
X-Google-Smtp-Source: AGHT+IF7ALO6MvOvwm6KwCpjJ++BRtE3omH4UZ9emT5VvC6HsqDzlDXlvVNEH456qch2muD1JzdO8Q==
X-Received: by 2002:a05:6402:4490:b0:564:693b:7679 with SMTP id er16-20020a056402449000b00564693b7679mr5062026edb.10.1708937586615;
        Mon, 26 Feb 2024 00:53:06 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id fi7-20020a056402550700b005648d0eebdbsm2109660edb.96.2024.02.26.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:53:06 -0800 (PST)
Message-ID: <dd0668ddecb21006123fca83dbaf6b993fa5f774.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: buffer: iio: core: move to the cleanup.h
 magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 26 Feb 2024 09:53:06 +0100
In-Reply-To: <20240225125336.682aa093@jic23-huawei>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	 <20240223-iio-use-cleanup-magic-v2-4-f6b4848c1f34@analog.com>
	 <20240225125336.682aa093@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 12:53 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:43:47 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> I think we can do more in here as a result of early returns being availab=
le.
>=20
> > ---
> > =C2=A0drivers/iio/industrialio-buffer.c | 105 ++++++++++++++-----------=
-------------
> > =C2=A01 file changed, 38 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-
> > buffer.c
> > index b581a7e80566..ec6bc881cf13 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -10,6 +10,7 @@
> > =C2=A0 * - Alternative access techniques?
> > =C2=A0 */
> > =C2=A0#include <linux/anon_inodes.h>
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/export.h>
> > =C2=A0#include <linux/device.h>
> > @@ -533,28 +534,25 @@ static ssize_t iio_scan_el_store(struct device *d=
ev,
> > =C2=A0	ret =3D kstrtobool(buf, &state);
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > -	mutex_lock(&iio_dev_opaque->mlock);
> > -	if (iio_buffer_is_active(buffer)) {
> > -		ret =3D -EBUSY;
> > -		goto error_ret;
> > -	}
> > +
> > +	guard(mutex)(&iio_dev_opaque->mlock);
> > +	if (iio_buffer_is_active(buffer))
> > +		return -EBUSY;
> > +
> > =C2=A0	ret =3D iio_scan_mask_query(indio_dev, buffer, this_attr->addres=
s);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
>=20
> We could short cut this I think and end up with a simpler flow.
> The early returns allow something like
>=20
> 	if (state && ret)=C2=A0 /* Nothing to do */
> 		return len;
>=20
> 	if (state)
> =C2=A0=C2=A0		ret =3D iio_scan_mask_set(indio_dev, buffer, this_attr->add=
ress);
> 	else
> 		ret =3D iio_scan_mask_clear(buffer, this_attr->address);
> 	if (ret)
> 		return ret;
>=20
> 	return len;

Nice...

>=20
> > =C2=A0	if (!state && ret) {
> > =C2=A0		ret =3D iio_scan_mask_clear(buffer, this_attr->address);
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return ret;
> > =C2=A0	} else if (state && !ret) {
> > =C2=A0		ret =3D iio_scan_mask_set(indio_dev, buffer, this_attr->address=
);
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return ret;
> > =C2=A0	}
> > =C2=A0
> > -error_ret:
> > -	mutex_unlock(&iio_dev_opaque->mlock);
> > -
> > -	return ret < 0 ? ret : len;
> > +	return len;
> > =C2=A0}
> > =C2=A0
>=20
>=20
>=20
> ...
>=20
> > =C2=A0
> > @@ -1326,21 +1305,19 @@ static ssize_t enable_store(struct device *dev,=
 struct
> > device_attribute *attr,
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > -	mutex_lock(&iio_dev_opaque->mlock);
> > +	guard(mutex)(&iio_dev_opaque->mlock);
> > =C2=A0
> > =C2=A0	/* Find out if it is in the list */
> > =C2=A0	inlist =3D iio_buffer_is_active(buffer);
> > =C2=A0	/* Already in desired state */
> > =C2=A0	if (inlist =3D=3D requested_state)
> > -		goto done;
> > +		return len;
> > =C2=A0
> > =C2=A0	if (requested_state)
> > =C2=A0		ret =3D __iio_update_buffers(indio_dev, buffer, NULL);
> > =C2=A0	else
> > =C2=A0		ret =3D __iio_update_buffers(indio_dev, NULL, buffer);
> > =C2=A0
> > -done:
> > -	mutex_unlock(&iio_dev_opaque->mlock);
> > =C2=A0	return (ret < 0) ? ret : len;
> Maybe just switch this for
>=20
> 	if (ret < 0)
> 		return ret;
>=20
> 	return len;
>=20
> So it looks more like the new return len above?
>=20

Ok, I typically prefer that form anyways :)

- Nuno S=C3=A1


