Return-Path: <linux-iio+bounces-8031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B052693FE9E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 21:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ABA1C225E9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E3188CD7;
	Mon, 29 Jul 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id3cqWdu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00960188CA3;
	Mon, 29 Jul 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282817; cv=none; b=n0/t8RCgPOPZVn3ICCUB172Cs2wRCbnkNOrSRMdZto6j03vIQzzzUvdRJmRhWQBkZo+SbOPc7djs+OutltWQbYvNSUOEP870KK21U3vcCIMJ8iBLQR0AvQjLXKsF6p0SE6R8oGkPP/QP7ArVZcStvSYU8ssOsap9LJ7DZEQBXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282817; c=relaxed/simple;
	bh=J9ybpcNDOP1sUvWx1UQzXipfsAb8eKeVODEPV4snaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV+QG3QNORKSGJ0I1LbWjnTWrZSQ/SDlF9TNY6FQC/Ciq1cR4CH9l6hnaHGTb+qsr564PlEzPxxu2+YuZJoPIiTmn6FsFyK97bdWr50xJPgXZfC9ltO7JA3yQSrpfWZNbrE1GaTyJHTrd3sq25U0z4Gm/HD/OGcCfpzi+4o/tGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id3cqWdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E304C32786;
	Mon, 29 Jul 2024 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722282816;
	bh=J9ybpcNDOP1sUvWx1UQzXipfsAb8eKeVODEPV4snaHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=id3cqWdupT2AVW+GqxtImDKo4WKAjeotUzomZ6ci3NfmQmlnt5YV5OEKYiJJEP2oY
	 TcPEH7mMk5SCzgrNJ4q1zrfjY7zXvB1OL6uGuRR4vPgqrEq4GdgB5qgwjbpSiTFZj/
	 e3kNzgg0XFjsKBQ9bV9CZ8BqtdbxgOUz9QWjz2kd0G6gcp95czvNIl7LJKYjkJ4a7+
	 jUEEh5dmzFIMNej5OzoVMQKSHFJ2SABqyX0YsFo9SN/ChN7j+OxZHwiLYAa+bZN2l1
	 NmwOcsM8RgZDSGPb6Fyje9mvZpKPAkiKjvejdg5te6UD94awlB0hzSOS2OJI//cNB/
	 yolNQyYqjavgg==
Date: Mon, 29 Jul 2024 20:53:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
Message-ID: <20240729205329.57390e20@jic23-huawei>
In-Reply-To: <20240729115056.355466-3-abhashkumarjha123@gmail.com>
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
	<20240729115056.355466-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 17:20:54 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Add new ALS channel and allow reading raw and scale values.
> Also provide gain and resolution configuration for ALS channel.
> Add automatic mode switching between the UVS and ALS channel
> based on which channel is being accessed.
> The default mode in which the sensor start is ALS mode.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

Patch looks good but one quick question.
Why not present an IIO_LIGHT channel?  Needs to be converted
to be illuminance (with scale / offset applied) rather than IIO_INTENSITY
which we use when the frequency response is different from the requirements
to measure Lux (and the units get very vague!)

Looks like what you have here is close, but not quite the right scale
factor as not including integration time and the mysterious 0.6 on the datasheet.

If we can provide a signal scaled to illuminance that tends to be a lot
more useful for things like screen brightness control because it should
be close at least to other light sensors.

Jonathan

