Return-Path: <linux-iio+bounces-20090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51CAC9C32
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867734A0163
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6E185955;
	Sat, 31 May 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvtzZpIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB57260A;
	Sat, 31 May 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748714974; cv=none; b=u1srl2q/f+5APyM3L4YQZsW+Hz6eeJCayfzLDsi1L2/kUKvVamjZetR8Kn85e+FQPFauwYn2du3K7Y13CzWOwpJytR7NHDnEc6QgaZ7T224IoSSnw00SVf5HrZqD7hDkLskaDXoo+2IaMiIPZCDUQXUNlUAujiIQrke3W2w+bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748714974; c=relaxed/simple;
	bh=gb0uZRUR+9QRJoit/ysAGvshX0ef0Mgkah6NHv/jSNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei6umm876fBskgk28JlofNfhJqlf56rWOk1yD6jxYrfla6ct1Wpm3JMJDrcivJcJL74EaDRJ2qG0FblG/zGsAe+Mv8M4JpZ+rgqAeEnZLy2INV8AGGCDby4C6Omwq7100ECTdHDE7PIPfudKhWvtcnej3iRLIyrTVRV3OtfWOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvtzZpIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28EFC4CEE3;
	Sat, 31 May 2025 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748714974;
	bh=gb0uZRUR+9QRJoit/ysAGvshX0ef0Mgkah6NHv/jSNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvtzZpIetEwHJXNmsrVr84J0zpdsTPeo07XICGQWkm8fWlEoDPZpZ/bfeHr1lTvAy
	 wQ1HlhBh+Tuq6nVzXywfKM12f/VmHRjXIx3Sou5OuaHhNUIoO12dxJ3YaCbJVKrcfT
	 8aEmaRgMQgUdXgo8wmiJXG86Td29xEm0JvgSPX3Wkbvb1kT3/WbtkHovb32mnNc0wP
	 JkRVYEtouHipkzkyjxuUhr/0/N8w+BfX7xQ8NGB4KeQqqzef2/AiFz95WLp+UAzNW0
	 x8pZR9PqX+wnIgkDshx13uprkXOrA5X5SEPI8HmBCukJpsHF1jRuaE8RQRQepHpkEB
	 tz4Dx2CevQC6Q==
Date: Sat, 31 May 2025 19:09:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/9] iio: trigger: Define timetamp-related
 structures and constants
Message-ID: <20250531190928.201bcd5a@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-6-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-6-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 23:25:58 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> The `trig_type` indicates whether the trigger calls poll() or poll_nested=
().
> The `early_timestamp` indicates whether the trigger grabs the timestamp a=
t the trigger.
> We need this to prevent the consumer from overwriting the timestamp.
>=20
> To allow the trigger to directly write the timestamp into the consumer's =
poll_func,
> add poll_func pointer member to the iio_trigger structure.
>=20
> However, I'm not sure if having a poll_func pointer member
> in iio_trigger is a good approach.
> Would this approach be acceptable?

I need to think about that.  My initial thought was that it crosses boundar=
ies
that we really don't want to cross.

I'm not sure I yet understand why we ever want the trigger to do that
write of the timestamp. Why are the wrapping handlers not enough?

>=20
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  include/linux/iio/trigger.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index bce3b1788199..f3b89a1e0318 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -36,6 +36,10 @@ struct iio_trigger_ops {
>  			       struct iio_dev *indio_dev);
>  };
> =20
> +#define IIO_TRIG_TYPE_POLL		BIT(0)
> +#define IIO_TRIG_TYPE_POLL_NESTED	BIT(1)
> +#define IIO_TRIG_TYPE_BOTH		(IIO_TRIG_TYPE_POLL | \
> +					IIO_TRIG_TYPE_POLL_NESTED)

I'm lost. How does a given trigger do both?

Also didn't these get used in an earlier patch?  Even for an RFC make
sure it bisects.

> =20
>  /**
>   * struct iio_trigger - industrial I/O trigger device
> @@ -56,7 +60,10 @@ struct iio_trigger_ops {
>   *			i.e. if we registered a poll function to the same
>   *			device as the one providing the trigger.
>   * @reenable_work:	[INTERN] work item used to ensure reenable can sleep.
> + * @trig_type:		[DRIVER] specifies whether the trigger calls poll(), pol=
l_nested(), or both.
> + * @early_timestamp:	[DRIVER] set to true if the trigger supports grabbi=
ng timestamp.
>   **/
> +
Stray blank line.
>  struct iio_trigger {
>  	const struct iio_trigger_ops	*ops;
>  	struct module			*owner;
> @@ -76,8 +83,13 @@ struct iio_trigger {
>  	struct mutex			pool_lock;
>  	bool				attached_own_device;
>  	struct work_struct		reenable_work;
> -};
> =20
> +	/* RFC, exists to access the consumer device=E2=80=99s pollfunc. */
> +	struct iio_poll_func *consumer_pf[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
> +
> +	int trig_type;
> +	bool early_timestamp;
> +};
> =20
>  static inline struct iio_trigger *to_iio_trigger(struct device *d)
>  {
>=20


