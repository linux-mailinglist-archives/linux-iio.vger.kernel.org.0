Return-Path: <linux-iio+bounces-823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31EF80D030
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD5B209AD
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C44C3A0;
	Mon, 11 Dec 2023 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HE440x8b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFAF101
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 07:57:32 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d3644ca426so43785297b3.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702310252; x=1702915052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnFsD1rGgCy3ClJpDI9oqAdCvPdJ7fZQsiqLqMiah4=;
        b=HE440x8bW4ivJ/FnJToCuXSWaSfYNrshA24kBJWkka43pvnWHamxqzAmOuBySjoHPK
         iMqTSBemht7BXYe63CuQyy9D8PlaUJab6eN6v63svBqK/p7M9/HRGp06p032eDJdxV2j
         tvD7zvmXeIApnJnDlvRNMS2gggQWQZKa3wsHr1oabl0UekJj2a700KvY+w7+ZomJvzLn
         Q6YzhLVJnkDgTuiFcZ1Pb98t8mttTYoHxuzTDH6pHj0ac4V4dhHMFUe0Fsgqf5swVA5N
         bmtPAAv8B+m5CJ9rFowIAeoBfVdO1LiDlYu/BJWZzURfRsTR54csFz/JpdcrUXCnLfYP
         H4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310252; x=1702915052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgnFsD1rGgCy3ClJpDI9oqAdCvPdJ7fZQsiqLqMiah4=;
        b=nMfViscsHLa+yqUMn6sISp/mW9mcbEvqL2cjre+uDHXOtBI/eFVrh58pbuDYT9ArSM
         +E6j9rszdlmBeaCHaQjjJqxepmOipYtqOXb0LSpD7nHSw1UTN+AsLkYphAmHvHAdkk3i
         RPl+jAA6GWtT58SkEe9Pbw47o0kdoI7fs3RG4xbm03MUOzo83sL0GrlbFZosy7vbj25l
         cM4XxOqfuaVAFmuha+Wlif62hmC/gHnEUM8YEsT8yYUZFlZtqUKN5NUZsxoiNZD6VHhV
         f/qJae9d7IMGKSRiapDQ16QMUTR/VgPgOv+eCTPqrqAHGQcP5ujulOdshKe/yfIbUJ1G
         5OdQ==
X-Gm-Message-State: AOJu0YyfvmCWuZbZ5Yl0/NcYt2ucPZ6oHf3wW94dluoCx33KrgNgmYNA
	YW3lgefFHnrZxQyE2HHcEh5/oQ==
X-Google-Smtp-Source: AGHT+IHTxt/NnusInkDn2gTlMNXzFT8tYbqqoQzEFJIeydEKudIkHqXrZd4hI95UwOkxyQCP0MFlEA==
X-Received: by 2002:a05:690c:2c90:b0:5e1:8d19:4e77 with SMTP id ep16-20020a05690c2c9000b005e18d194e77mr287921ywb.8.1702310251910;
        Mon, 11 Dec 2023 07:57:31 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id d201-20020a814fd2000000b005cc5f5aa533sm3066544ywb.43.2023.12.11.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:57:31 -0800 (PST)
Date: Mon, 11 Dec 2023 15:57:28 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tools/counter: add a flexible watch events tool
Message-ID: <ZXcxaFRuGJg6kYuT@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DgK1nOAauTq8w6Yp"
Content-Disposition: inline
In-Reply-To: <20231206164726.418990-2-fabrice.gasnier@foss.st.com>


--DgK1nOAauTq8w6Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 05:47:25PM +0100, Fabrice Gasnier wrote:
> This adds a new counter tool to be able to test various watch events.
> A flexible watch array can be populated from command line, each field
> may be tuned with a dedicated command line sub-option in "--watch" string.
> Several watch events can be defined, each can have specific watch options,
> by using "--watch <watch 1 options> --watch <watch 2 options>".
> Watch options is a comma separated list.
>=20
> It also comes with a simple default watch (to monitor overflow/underflow
> events), used when no watch parameters are provided. It's equivalent to:
> counter_watch_events -w comp_count,scope_count,evt_ovf_udf
>=20
> The print_usage() routine proposes another example, from the command line,
> which generates a 2 elements watch array, to monitor:
> - overflow underflow events
> - capture events, on channel 3, that reads read captured data by
>   specifying the component id (capture3_component_id being 7 here).
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3:
> - Free the allocated memory, also close the char device
> - Split of another patch series[1].
> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier=
@foss.st.com/

Hi Fabrice,

Thank you for splitting this from the other patches. I think you may
still be leaking memory in a few places below.

> +	if (nwatch) {
> +		watches =3D calloc(nwatch, sizeof(*watches));
> +		if (!watches) {
> +			perror("Error allocating watches");
> +			return 1;
> +		}
> +	} else {
> +		/* default to simple watch example */
> +		watches =3D simple_watch;
> +		nwatch =3D ARRAY_SIZE(simple_watch);
> +	}

If we go down the calloc() path, then we should free the memory
before any return.

> +				case WATCH_CHANNEL:
> +					if (!value) {
> +						fprintf(stderr, "Missing chan=3D<number>\n");
> +						return -EINVAL;

Such as here.

> +					}
> +					watches[i].channel =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				case WATCH_ID:
> +					if (!value) {
> +						fprintf(stderr, "Missing id=3D<number>\n");
> +						return -EINVAL;

Here.

> +					}
> +					watches[i].component.id =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				case WATCH_PARENT:
> +					if (!value) {
> +						fprintf(stderr, "Missing parent=3D<number>\n");
> +						return -EINVAL;

Here.

> +					}
> +					watches[i].component.parent =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				default:
> +					fprintf(stderr, "Unknown suboption '%s'\n", value);
> +					return -EINVAL;

Here.

> +	ret =3D asprintf(&device_name, "/dev/counter%d", dev_num);
> +	if (ret < 0)
> +		return -ENOMEM;

Here.

> +	fd =3D open(device_name, O_RDWR);
> +	if (fd =3D=3D -1) {
> +		perror("Unable to open counter device");
> +		return 1;

Here.

> +	}
> +
> +	for (i =3D 0; i < nwatch; i++) {
> +		ret =3D ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
> +		if (ret =3D=3D -1) {
> +			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
> +				strerror(errno));
> +			return 1;

Here.

> +		}
> +	}
> +
> +	ret =3D ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> +	if (ret =3D=3D -1) {
> +		perror("Error enabling events");
> +		return 1;

Here.

> +	}
> +
> +	for (i =3D 0; loop <=3D 0 || i < loop; i++) {
> +		ret =3D read(fd, &event_data, sizeof(event_data));
> +		if (ret =3D=3D -1) {
> +			perror("Failed to read event data");
> +			return 1;

Here.

> +		}
> +
> +		if (ret !=3D sizeof(event_data)) {
> +			fprintf(stderr, "Failed to read event data\n");
> +			return -EIO;

And here.

> +	if (watches !=3D simple_watch)
> +		free(watches);
> +	close(fd);
> +
> +	return 0;

We finally free watches here, close the file descriptor, and return. So
instead of returning an error code directly when you encounter a
problem, I would do an unwinding goto section like the following
instead.

First, the open() call occurs after the calloc(), so move the close()
call above the watches check so that we unwind in a first-in-last-out
order. Next, add a label to mark the file descriptor close section, and
another label to mark the watches free section. Then, rather than
returning 0 directly, return a retval that we can set. That way, when
you need to return on an error, set retval to the error code and goto
the file descriptor close label if we're past the open() call, or the
watches free label if we're just past the calloc() call.

William Breathitt Gray

--DgK1nOAauTq8w6Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZXcxaAAKCRC1SFbKvhIj
KyH7AQDS6pGsvZkqLTWO56L/iANt86BNInqaN0ixwVhpsDcpBgD/dVb/3cacHHOH
q1S50LhsUQ4jogqKhU20axDclAOqvQQ=
=3Fgn
-----END PGP SIGNATURE-----

--DgK1nOAauTq8w6Yp--

