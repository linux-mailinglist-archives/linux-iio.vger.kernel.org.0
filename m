Return-Path: <linux-iio+bounces-8399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D707994DC48
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EF91C20EFE
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCC157A61;
	Sat, 10 Aug 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9gPX5W/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F62F2A;
	Sat, 10 Aug 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285641; cv=none; b=Z3N+WW7aLD5/Uwmss59cKjYYuTSXb/EzHF7r7bG7A/h1NjnidRlV/8/ERESb2kMQwluNPQb9egT6qsPs2tH2JWuo1O3UBNdXaTKdogtf2fcBS7Lo/p326zX7qEKE1YrA22eqCwdJt4ZVbRveTIKde41DQEii5yDASTKnQ5PYBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285641; c=relaxed/simple;
	bh=4p1ePSehn6ap5Nr4r9eTXpSRW2G1jRSVhIhPjiiBpUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLlGva+Mwe0bBujy9JXvJB/DJ8k7uFu8WOXv/XSV57h6FFY1nlzJ4GoTS0ogol72Svg6HOukx6Q2e7H1ErBVn/raPFGmWP9GKpns+rcW4g57rJcLmy+UWwXPb110SvMsKGN4ZhsNKNgxuOZ1+ENyzwOvt5GrrHEwqUbyq2UaznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9gPX5W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6CEC32781;
	Sat, 10 Aug 2024 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723285640;
	bh=4p1ePSehn6ap5Nr4r9eTXpSRW2G1jRSVhIhPjiiBpUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q9gPX5W/BtB6fZkWzxeQtX8m1z+0ElHnXjrxBxiM6TrKEICi7ukNQdR1mzsWCT/sl
	 KVmwR7ciiDrkI6McW4pHIQWy6+pEXijIJIEiKFx9NQweps0j+ZpU84GxVgvZiTa9Pt
	 iSO4HWaz8/ni8o3cibIONX1m4HgSFknC6yYavH8+hH+at8QMr2YBLxe2PpUtwy7ktA
	 F+zPF5gQA/cWHTf35a4kcyTj5iTI1yZ4W3ZqJ1rd/d3lbzbSanLtvZAnNnVB5f7SxQ
	 0axncJFjBcUIDkIYJLlxx6by1H8ZI/r2713qWSx6mD9AJBQcXZL0c3FVuV03UrLvsr
	 E1wGUuGKl+jaw==
Date: Sat, 10 Aug 2024 11:27:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH v2 1/3] iio: magnetometer: ak8975: Fix reading for
 ak099xx sensors
Message-ID: <20240810112712.191d6576@jic23-huawei>
In-Reply-To: <45915CD6-A9BB-4071-ABCC-8DE76F7066C3@mainlining.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
	<20240806-ak09918-v2-1-c300da66c198@mainlining.org>
	<20240806171925.7c512c63@jic23-huawei>
	<45915CD6-A9BB-4071-ABCC-8DE76F7066C3@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 19:54:56 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> On August 6, 2024 6:19:25 PM GMT+02:00, Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >On Tue, 06 Aug 2024 08:10:18 +0200
> >Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:
> >
> >Hi Barnab=C3=A1s,
> >
> >Welcome to IIO.
> > =20
> >> ST2 register read should be placed after read measurment data,
> >> because it will get correct values after it. =20
> >
> >What is the user visible result of this? Do we detect errors when none
> >are there?  Do we have a datasheet reference for the status being
> >update on the read command, not after the trigger? =20
>=20
> Second read will fail. In the datasheet ST2 comes after measurment data r=
ead. Here is some explanation from datasheet.
>=20
> "When ST2 register is read, AK09918 judges that data reading is finished.=
 Stored measurement data is
> protected during data reading and data is not updated. By reading ST2 reg=
ister, this protection is
> released. It is required to read ST2 register after data reading."
>=20
Thanks. Please add more of that detail to the patch description for v3.

> So if ST2 is read before measurment it will stuck at protected mode.
> >> =20
> >Needs a Fixes tag to let us know how far to backport the fix. =20
> I think it is broken since 09912 was added but i cannot verify i have onl=
y devices with 09918.
> >
I wasn't meaning devices, but rather what patch broke the kernel code.
It might be the original driver introduction.

If we can add a Fixes tag that makes it much easier for stable + distributi=
ons
to work out whether to pick the fix up or not.

