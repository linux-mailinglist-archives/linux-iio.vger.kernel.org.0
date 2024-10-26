Return-Path: <linux-iio+bounces-11310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B89B173C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76AB1F2304E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560D18308A;
	Sat, 26 Oct 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjCKoBnj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41A217F22;
	Sat, 26 Oct 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940562; cv=none; b=Ik7Ur/FsDM9oWCVbFZFG8VVdlizIpItp8bPGQTPV4cgQH0x3YkNTaO4rrL9/sjzEHMOQpjBIVL7rFF65yK8hgXF0jcWChSlQhxDveJO3a94Ku5Bbhd3b1qARBgCPXGl9cdHQVbeYNmmCZsIQ8+pQvEFr+H4jNRQ56N11YZTKr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940562; c=relaxed/simple;
	bh=2+e2mkXeYY/1Bbeta2CvQuMBxUdG6325UmJ8QQzA0KY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyzN++YbuLRyuwxWjtNMDf5Yun1IW2E4iBFOJovJNrMBer9JwuM2X5Zcf88hdY4EGpwsIuCHWAYnMdwT+c4sch+Hz9f8P5Y0hT7ccjJj8eX1Lr2Ajn+CgubRWd01qOhZ/x1qQH6Q3W/4JEbMYfVhO4jKDddHH3pQc00n2H/HESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjCKoBnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24D0C4CEC6;
	Sat, 26 Oct 2024 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729940562;
	bh=2+e2mkXeYY/1Bbeta2CvQuMBxUdG6325UmJ8QQzA0KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YjCKoBnjxrXWTBahClag5j3YE1tq8dvrSAJjXnT2e34DgGQKSotgwxTBwz4uMWxvY
	 O1ZjKlNcavNFQAGrmXAVlnRletm9yAPxrQEPihvuQLlU1gxI6VQ0PWk6jP9n3j/JVQ
	 FxLv+4q+68bMeNNTbsbvpjFssXIDaRVI+LcZOdMbe1eoeEOpnLxH9QeyU85wz5jaND
	 OYgImW93/fnG1XUkkkR2NeGcJpEJoXQTZNND44CjyZAXO/MpDH+1LH+6Dv8jHiA6ZP
	 7+kn94GiKvUAwy/dG/NCxzDYQCzukiy4lZ3Ff0iRzgn35w2aPcsR+kUSWuWrqO6g/f
	 rCO0JJUnYDqBA==
Date: Sat, 26 Oct 2024 12:02:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 01/24] iio: magnetometer: bmc150: Drop dead code from
 the driver
Message-ID: <20241026120236.743c6f70@jic23-huawei>
In-Reply-To: <20241024191200.229894-2-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:50 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since there is no ACPI IDs for this driver to be served for,
> drop dead ACPI bits from it completely.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Given lots of somewhat independent stuff in this series, I'm going to review
an pick them up one by one.

Applied this one.

Thanks,

Jonathan

