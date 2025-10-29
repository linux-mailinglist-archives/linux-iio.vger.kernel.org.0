Return-Path: <linux-iio+bounces-25627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC1C1C663
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D36B4EA4D5
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9FF34AB0E;
	Wed, 29 Oct 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx+aVWw+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4B32ED4B
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757955; cv=none; b=Xk5OyVL9nsj1Hq8XxzEJAFG/PUuDuWnioyxNw+ghc/GB4GecKICrTG3G0LSOB3w9pbXhToBOrLYV3BGimlg03LjI8JLZoJBIi+whACNtuTg0vHb9urhvD9/9e0fSQk1jy27fvtkhF5/tLrZKZHR0BsPp1e7Yp5syXXzma6yPiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757955; c=relaxed/simple;
	bh=eOLXBtbMM5UAZSF7rSO/n12cHSatk8np+La0omC0gQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFFcJ+VyvIXTCefysfe/rnCojlhmMiwDf4nQPfbszQYHZhkG0J7sqzRrrE2xSY8qka0ufPofamGNWfkABjDM1FtpQCtw2yb4UFV5qpyNzu7lyM0H4aAzIH97T7HM4rGDizUZyyHLRHjSgqFLoWPaOCEk0TUZvnf+PtElsH4E+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx+aVWw+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af743c232so143547b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761757953; x=1762362753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnKpCH58GdNF1l2XFRSs1X37/8N+qbe+dP+a5Rvfzi8=;
        b=Dx+aVWw+nh5g/sN7104gwgOt0diZz49p1d5D+aqpEk34WmOQ+xYzp/7C9bqLuN96bv
         J+7R4CQ4WNVtsz4DFg2ng4IHGr3WvLy4vaVjZ6rMLB2OZ81n3cSZX+TPma3q9EjEA460
         x/PU+GYfQdoyKbvM9McD5eyhkhB2kdJ0IwO9tyJt1wBGA9sAAt3Pt6/Skz8RBnXDWe7a
         ExXn6wh9Sdz5oKT3I9OfhSK3uH5WtCC4ZwkVF77PMowmRyukM4kJkwAtiDKP0jEFfWmO
         cUHO484IpnrBEnHr/jer8kDcXXTuD3XUOkmxHIMkuhBM0Vd9ZaiIjCZHh/tq+H0zk+en
         vMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757953; x=1762362753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnKpCH58GdNF1l2XFRSs1X37/8N+qbe+dP+a5Rvfzi8=;
        b=i0kNTciwjlore550x1X6izUJn+Vj6qgoaB5q/J/5yFSMf3kYMzmydwwBq9kbj5LAZE
         Rp2IBMgYctuVeT2vx41Wgdz2P6Vwx6KYZXxuDlH1qnl+g0881659V5/HaAkzX9YiGaxA
         EWBLqHfhQ+10C3aUmfnidv4m+zNJp3SX5qKl0C/LPdP5l2UFikVMc/MMjOMLwNMooJsz
         201DN4zyJDNym+Rtjy/tTgj9rsa83/QuhbOCW8J69B46sR+BfmgzHowU1gwrXeWoGImP
         F50Fk4msbaiEFkfb85p2yQw0vfARHO2+af01shBhzoj3ps/im2XJhemhliggKIME4pyB
         /Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqF6BnpkGyKeq0uSKzgrSj40cUgRGLUc6lci83N+z/1JDGKvkO42Nzy5tcf12k3NmGFVTTeNCIQeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsdnCQQKEKSyOWAjLW8EJv6F0QwnScNdbWnKKw/C3LPFJqWrD
	4adBpq6WETsJAL/9TvnKfa2FWrK4WiLmE18JqBp+Fdi4r8F9O1XfDAEV
X-Gm-Gg: ASbGnctTTeRx3xE4sAZKZWyBqmWODrPXvqMFdPJFClANwCyZ+Dnk6zTjj3mE4UvSYUn
	oT0cYQeTfmYkX7M+ZHOHu6J1hBmb7sjvkSndgCz+I7TLnyc1E2RdtWU9+3VjZf9oKPb1dRhIwPE
	9EKjTq/cFvdWml9YiliXU7IGnFbk0LQqudS3yYtfslidmoDGEKCh8nEjSUxzOdV4Ms6PScRxFiO
	zMzi2G2MsiMJNgAYWKx89fJ6rOJqpUWirUtaIUCeqvN1hU/LUvk3JTlSMy8wobWiTLly106MmRe
	Hed/JgNS/PIBsQwqwLkLVJqDizQ5immwH3Z7POvmI7XyQl28+9zC9ei+6+riWcCJe+4Nxp+kt5V
	oDD3ROFty3B7WxLBgVBydj8lQqw/P4bHvBL2cchCX6TGQSdLtR/tPBOgv3L+1jboR2RnobqZd/a
	QFTpz//FRDEg==
X-Google-Smtp-Source: AGHT+IHQMbLbWUPCYW1JGa0pgg6AYFvnsbZAHjKMpoS0KlUCa9pQd5ShhIa2kP6pC0CtsHA0HZU9Dw==
X-Received: by 2002:a05:6a00:c86:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a4e290d787mr4710460b3a.5.1761757952487;
        Wed, 29 Oct 2025 10:12:32 -0700 (PDT)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a414065418sm16047441b3a.41.2025.10.29.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:12:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:13:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mpl3115: add threshold events support
Message-ID: <aQJLR-DrdVRQ3dc1@debian-BULLSEYE-live-builder-AMD64>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028213351.77368-3-apokusinski01@gmail.com>

...
> +static int mpl3115_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 int_en_mask;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
> +		break;
Usual convention in IIO drivers is to return early whenever possible
		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_PTH);

> +	case IIO_TEMP:
> +		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
> +		break;
same here
		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_TTH);

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return !!(data->ctrl_reg4 & int_en_mask);
> +}
> +
...
> +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int ret, press_pa;
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    MPL3115_PRESS_TGT, 2,
> +						    (u8 *) &tmp);
> +		if (ret < 0)
> +			return ret;
> +
> +		/**
> +		 * Target value for the pressure is
> +		 * 16-bit unsigned value in 2 Pa units
> +		 */
> +		press_pa = be16_to_cpu(tmp) << 1;
> +		*val = press_pa / KILO;
> +		*val2 = (press_pa % KILO) * MILLI;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;

Looks like this is intended to provide the value in kilopascal. Though, as
specified by pressure_raw ABI [1], we only get to kilopascal after applying
channel _offset and _scale. So, this would have to use _input ABI [2], or
provide a value that can be scaled to kilopascal.
If I'm not missing anything, 

		*val = be16_to_cpu(tmp) << 1;
		return IIO_VAL_INT;

would comply with the _raw ABI.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio?h=testing#n397
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio?h=testing#n1061

> +	case IIO_TEMP:
> +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Target value for the temperature is 8-bit 2's complement */
> +		*val = sign_extend32(ret, 7);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 tmp[2];
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		val = (val * KILO + val2 / MILLI) >> 1;
same here. You seem to want to use the _input ABI.
Or, if you chose to use the _raw ABI, take the raw threshold value
		val = val >> 1;
		if (val < 0 || val > 0xffff)
			return -EINVAL;
...

Might also use a local variable to hold the adjusted val >> 1 pressure threshold.

You may also add docs for those. e.g.
What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
and
What:		/sys/.../events/in_pressure_raw_thresh_rising_value
to ABI documentation.
The ABI doc would probably be best appreciated in a separate patch.

> +
> +		if (val < 0 || val > 0xffff)
> +			return -EINVAL;
> +
> +		tmp[0] = FIELD_GET(GENMASK(15, 8), val);
> +		tmp[1] = FIELD_GET(GENMASK(7, 0), val);
> +
> +		return i2c_smbus_write_i2c_block_data(data->client,
> +						      MPL3115_PRESS_TGT, 2, tmp);

With best regards,
Marcelo

