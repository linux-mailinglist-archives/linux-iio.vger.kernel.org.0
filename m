Return-Path: <linux-iio+bounces-7372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14938929291
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FF11C20D74
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078055E48;
	Sat,  6 Jul 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiSyRn5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21442A85
	for <linux-iio@vger.kernel.org>; Sat,  6 Jul 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261694; cv=none; b=J8Y3Tt6qE/0VxwDZ8uINOE9xPJtwgyXxWRv09oQZITsRgtZ/cljJ4UwrwSavuI1iRvFNVdoze3iL/wwUDU1ceKRYEX6041mN1Qz3SuyFh9FVsAvCp3KJggSYWuHA7jXQnK0bejMqapuYxowFadczolhJz7Mn9ikFsPQjZGEPHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261694; c=relaxed/simple;
	bh=G5OqHkwu/ytAc1ODej9ZQpEkyfAVeXRR/BN7kHlCmLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpqoheiKlSsITVmC3pr4E3BdKPM9WS0+IVWj0qaiE3IvKPoWw1P2zO5zCviyfsjg5kKA5PJJTdOIkT3whlUToRIe3IWztyj0Q0CUz7jeQFpKcodc2TnJAwK3/+a6iqbRTGod1ty5+yqdo+W/IA4eXXn1E4JKgzkA7dfkxbiDMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiSyRn5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F3C2BD10;
	Sat,  6 Jul 2024 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720261694;
	bh=G5OqHkwu/ytAc1ODej9ZQpEkyfAVeXRR/BN7kHlCmLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MiSyRn5b1UwUktP4e02x8nCTgaRgmuMIC+evsWznu9BQ+6dO4W11Cjcasac2mXIwm
	 mx82rbIsC2V5nW+zFnKXD2kGRCueytKkGo8dzp2PDwqrogp6bvmNDbl9rHK/M0ORNp
	 valQ5UAMNlY3OKFJTdC13mxpzCvFpFgOM/BtotufiqWODGBi/2oQAtNj9PGozGL9tg
	 URcyUl6Ppy8tJbCdx2+q1J/az0pZRobA4Lac7jB5sU2mx5S0Vub1TuHiTKpWb5HUlD
	 /8pHa8D8LCfiO07dorA7DMBtE0XVeI4TkA+dzMK6RNL8N3SAkQwNqQrhP4whcQc0g8
	 IBfhQw+pilGcA==
Date: Sat, 6 Jul 2024 11:28:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Mereena Mathai Liquancin (MS/EMS3-BST)"
 <Liquancin.MereenaMathai@in.bosch.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Subject: Query Regarding IIO Patch Submission and Inclusion in
 linux-next
Message-ID: <20240706112807.6fd69e5b@jic23-huawei>
In-Reply-To: <AS2PR10MB77388143DBA2ACC76CFD6568C0DF2@AS2PR10MB7738.EURPRD10.PROD.OUTLOOK.COM>
References: <AS2PR10MB77388143DBA2ACC76CFD6568C0DF2@AS2PR10MB7738.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jul 2024 11:53:22 +0000
"Mereena Mathai Liquancin (MS/EMS3-BST)" <Liquancin.MereenaMathai@in.bosch.=
com> wrote:

> Dear IIO Maintainers and Community,
>=20
> I hope this message finds you well.
>=20
> We are planning to submit a patch to the IIO subsystem and would like to =
clarify the process for its inclusion in the linux-next branch.
>=20
> Our question is: Once our patch is approved by the IIO maintainer and mer=
ged into the iio.git<https://git.kernel.org/pub/scm/linux/kernel/git/jic23/=
iio.git> repository, can we expect it to be included in the linux-next<http=
s://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git> integratio=
n testing tree (kernel/git/next/linux-next.git)?
>=20
> Understanding this process will help us manage our expectations and timel=
ines more effectively.

Normally there is a short (typically around one week, a little longer when =
merge windows
are open or about to open) gap between when I pick a patch up and inclusion=
 in linux-next
(that includes the togreg branch of the above tree).  The reason for that i=
s to provide an
opportunity for early feedback from 0-day on any build issues etc before ma=
king a mess of Linux next.
That automation runs against the test branch of iio.git.=20

Jonathan



>=20
> Thank you for your time and assistance.
> Best regards,
>=20
> Liquancin Mereena Mathai
>=20
> BST Projects (MS/EAC3-AE)
> Bosch Global Software Technologies Private Limited
> (CIN: U72400KA1997PTC023164) | KGISL Infrastructures Private Ltd - SEZ Ke=
eranatham Village | Coimbatore | Tamil Nadu - 641035 | INDIA | www.bosch-so=
ftwaretechnologies.com
> Liquancin.MereenaMathai@in.bosch.com<mailto:Liquancin.MereenaMathai@in.bo=
sch.com>
>=20
> Registered Office: Bosch Global Software Technologies Private Limited - (=
CIN: U72400KA1997PTC023164)
> (Formerly known as Robert Bosch Engineering and Business Solutions Pvt. L=
td.)
> 123, Industrial Layout, Hosur Road, Koramangala, Bengaluru - 560095, India
> Managing Director: Mr. Dattatri Salagame
> =E2=80=8B


