Return-Path: <linux-iio+bounces-24496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9619BA618E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699E5380BD0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB092236F2;
	Sat, 27 Sep 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfDQm0Hq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB014BFA2;
	Sat, 27 Sep 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990875; cv=none; b=RWO4lEmDoocBhKubX5BewGd7p5foQ3xXo2jWxB84rJiuJW4h9TbIdIWMAJVKFl73N2jjQEVjCf2Eu+M+G12EKd/UavbqsV4scopSBSX1LXx0j+Y/4syEPqjAw9eT6Cwdlb1lNzm8OxhM1aP5yVKZEJCkRiAdghTzqMpgxtKuIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990875; c=relaxed/simple;
	bh=qeZC/pRCYJMpr65N9mvjYbg04no3ilGBhi0vFHl4+OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sl+6j8w+zVyT8oXKJImJgyN3iGii97Y6zHjS7ZNoq5QyWfOI/vH4nMcjvkm0LjF6ks0Z4Gn47aRrV4e62zhCdmAlxwyYob5GWakgP/grVS1jzwneQDLfeL0Pc4qJtOWd3fPDB1fT79gtSrn3IUBC3oXoR+9muCMWE2w1KXKANVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfDQm0Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E16AC4CEE7;
	Sat, 27 Sep 2025 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758990875;
	bh=qeZC/pRCYJMpr65N9mvjYbg04no3ilGBhi0vFHl4+OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfDQm0Hq0h7niCVSsnjvSf4VehE9pbDsK/HN0UHa1EYuaTbX1aw3RSmcJUZ42yWYs
	 SwBW8t4o55Dy4DPhvyg+QgHnlRKnyt8/gfxLvI+Hmg5APz5qWnu5CMBOo1ts1EoEL3
	 nFwmLtiJndbcpFaO2qeZJzdOsV+HKasgCD4gksuyG0Q13Qv2c2s2s3w3SsXihdMHWY
	 zhvid1RJVOVpHMkNL8JcGrSwqZ2IiwB/miUaV38RhZul3KmZw/b9s0tFUJnblVq8mb
	 KZtTVdVeMj4TDxQqhk0tRc4EPw0qmWDcmNxZVinQVYkPa+05Ik6+x1qZkPqRWBNcpq
	 2cQyogJvESSUA==
Date: Sat, 27 Sep 2025 17:34:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux@roeck-us.net,
 rodrigo.gobbi.7@gmail.com, naresh.solanki@9elements.com,
 michal.simek@amd.com, grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250927173423.1eada3a5@jic23-huawei>
In-Reply-To: <CAHp75Vd8Bwk8HVc3DhG4L=SgbSh3aFTQ2VRn7Tri8YhJrqaXgw@mail.gmail.com>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
	<20250921133327.123726-3-apokusinski01@gmail.com>
	<CAHp75Vd8Bwk8HVc3DhG4L=SgbSh3aFTQ2VRn7Tri8YhJrqaXgw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> >         mutex_lock(&data->lock);
> > -       ret = mpl3115_request(data);
> > -       if (ret < 0) {
> > -               mutex_unlock(&data->lock);
> > -               goto done;
> > +       if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
> > +               ret = mpl3115_request(data);
> > +               if (ret < 0) {  
> 
> > +                       mutex_unlock(&data->lock);  
> 
> Instead, I suggest adding a prerequisite that moves the driver to use
> cleanup.h, in particular scoped_guard(). This will reduce a churn
> here,

I'll comment on this in version 3, but I'm not sure scoped_guard() is
necessarily a good idea here.

Also note that there is no requirement to use one style universally in
a driver (guard / vs explicit unlocks) as often they work best in different
usecases with the same locks.
> 
> > +                       goto done;
> > +               }
> >         }  


