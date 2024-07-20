Return-Path: <linux-iio+bounces-7721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98B938091
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B711C20E34
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582187829C;
	Sat, 20 Jul 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEtDNKh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4015AE0
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721469436; cv=none; b=hQNLj3gbG7mhH7ThcALBEhGCA4KBzJpA7lIbaD/wdwmF8oPjeAKgGjkwMfCHVhFgbFNlER7wRPnOzupK3lnnJZbsPYXWiOlbNkNCOe7oZcU8NbW6DlUX2hKiWg5nfasE+sISkUPJ2k3KBvGTpuIyEdsqYKoU+61jnFLf3RzFbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721469436; c=relaxed/simple;
	bh=Ka0rY7E+UzsEsmdeJ43SkwZBnxeC6icj4Nc++tU8Xsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7Y5Gc6AvtUwaeHfQykLq77WvuS1kzukQI5nnwdksKiuUdFDGy0avuC4Nle6CsVyNivRzejWcPrmeWGHN+qs/SExIg7yYElrzfdaPvCZLG9ct3AD3U9QYETrUD3B3t6iqIaWXcbeTr4PN8m+milydU5xmH3sUzn2Wn/0wVnUEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEtDNKh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693CBC2BD10;
	Sat, 20 Jul 2024 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721469435;
	bh=Ka0rY7E+UzsEsmdeJ43SkwZBnxeC6icj4Nc++tU8Xsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nEtDNKh1r5sCDAhKpI7cWOTTENOF9d7MHlcApFkEmYv0PquoMibVO2M2z9XGY2oAf
	 TziJgcKVOmdbC9MA9fllDzWohGwTF1AunCO+CVo+EH76Wz6G61Rl1NOgC5q38PsMDB
	 pze/NW+roVAgNvWvmbiKQ+GOecJV9vNd2gENJcKJMyACuJNUdH5guyXeSpONQAehYZ
	 JtRLMetRuejv+UsinMCFlO9ttxkCACo7sYIl5n0hvr4mGqNO9jj7rvttKkNp6wH9PZ
	 eWHxqyCeGdMBpqi29k9x3qwQjphYZ6gZZO2C0ATSq1Du6UviVqbFpQ+IwglUlsYOQ9
	 /QxytxFXrBPJw==
Date: Sat, 20 Jul 2024 10:57:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 9/9] iio: adc: ad9467: add digital interface test to
 debugfs
Message-ID: <20240720105709.7e666a8a@jic23-huawei>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-9-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	<20240709-dev-iio-backend-add-debugfs-v1-9-fb4b8f2373c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 13:14:36 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> One useful thing to do (in case of problems) in this high speed devices
> with digital interfaces is to try different test patterns to see if the
> interface is working properly (and properly calibrated). Hence add this
> to debugfs.
> 
> On top of this, for some test patterns, the backend may have a matching
> validator block which can be helpful in identifying possible issues. For
> the other patterns some test equipment must be used so one can look into
> the signal and see how it looks like.
> 
> Hence, we also add the backend debugfs interface with
> iio_backend_debugfs_add().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Rest of this series looks good to me.

So just that discussion on naming / directory stuff of debugfs to resolve
and document.

