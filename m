Return-Path: <linux-iio+bounces-17342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B42A75A80
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B2188BBB4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3861D5AC6;
	Sun, 30 Mar 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP8RUAOr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16783C3C;
	Sun, 30 Mar 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743347607; cv=none; b=lYj19iWG1ktiYFTi22be+e23U5/K7ckEQd4i9ROmaO2MPTgk5Td5JDHkDR5eDZQw5vvz8Ba9tAASZwaQyjf3vKh+DZCCH7rGW8WElywx46171aHR13b+a7Be0odHPmn6pM12/gDKRrOEPcuH5S7YZB1AcoH+kJbZjVgtCKe9huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743347607; c=relaxed/simple;
	bh=OO+ddB6jXqbazFwzyc+1bl2E8ekrpgxwXY7ouvovQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtPQ9rMhL28pF1daXrWvMnUuNuoX6iNeJSOJGrKjHzCv013WKD/MZefj6CF6TA7yuWzTq7yslBFAnmh4yAgOLtdEKzyck2MJ4sAdk6fN5ImchwqNxgj1kYzm9RmmZvFXpxHkKI6rnTVRYvrtu7PDdRS019rAZrxAYVEdEL5s7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP8RUAOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BADC4CEDD;
	Sun, 30 Mar 2025 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743347607;
	bh=OO+ddB6jXqbazFwzyc+1bl2E8ekrpgxwXY7ouvovQhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oP8RUAOrbT60js2Pt3PDu1tBKh8Y9Ij8ePnsYnDJpZViq3YTaf1xGdwd4TPNgkUCQ
	 BHuwbCdHkiKHGIXIhGKexViUIllL2GVr428bvXqo/8qr6E3ETcR0eeOrjZLyF0f5+w
	 69rn4F/I0vHkJh5khV7e3w3MY9y6cB4jg/01nEK2xVEP9euvwU5lxSwdaL7f6ybpkt
	 ehFwIcNA3KvPF6Qa1hs5ofAJxyDxtKQ4OqdCqlqoFu6NvaX1CdkhAVXcGR4iYSbac/
	 E9HKwTZcfXSsOmYH4JQa7ytzAspLFHl84jZCRnlw/EIpGZs4oinfm2YILy1xwEqpjZ
	 gUCWub+YQiBAg==
Date: Sun, 30 Mar 2025 16:13:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 bpellegrino@arka.org, Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq
 margins
Message-ID: <20250330161317.4f537c86@jic23-huawei>
In-Reply-To: <Z9mKghgKk9vuHUyF@65YTFL3.secure.tethers.com>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
	<20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
	<Z9g6tPqhAoTckFBh@65YTFL3.secure.tethers.com>
	<20250317185535.7d00444d@jic23-huawei>
	<Z9mKghgKk9vuHUyF@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 11:00:18 -0400
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> On Mon, Mar 17, 2025 at 06:55:35PM +0000, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 11:07:32 -0400
> > Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> >  =20
> > > On Sun, Mar 16, 2025 at 05:38:42PM +0100, Krzysztof Kozlowski wrote: =
=20
> > > > On Sun, Mar 16, 2025 at 09:50:03AM -0400, Sam Winchenbach wrote:   =
=20
> > > > > From: Sam Winchenbach <swinchenbach@arka.org>
> > > > >=20
> > > > > Adds two properties to add a margin when automatically finding the
> > > > > corner frequencies.
> > > > >=20
> > > > > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > > > > ---
> > > > >  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++=
++++++
> > > > >  1 file changed, 20 insertions(+)   =20
> > > >=20
> > > > I don't understand. You got my tag. No changelog here, no cover let=
ter,
> > > > nothing explains what happened here and why the tag is being remove=
d.
> > > >    =20
> > >=20
> > > Apologies,
> > >=20
> > > I am still quite new to this workflow, and it deviates significantly
> > > from my day-to-day work. I mentioned in the previous patch set that I
> > > would like to update my email address and change:
> > > "driver core: -> iio: core:"
> > > I wasn't aware more than that was needed. Sorry for any confusion
> > > this may have caused.
> > >=20
> > > In the future what is the preferred way to handle a
> > > situation like this? I wasn't aware of the cover letter feature but
> > > that looks like a promising option. =20
> >=20
> > Either add stuff below the --- above as that doesn't end up in the
> > eventual git log, or --cover-letter on your git-format-patch and
> > put useful things like that in there.
> >  =20
> > >=20
> > > It looks like another option is to add commentary to each patch.
> > >=20
> > > I am less certain about your tag being removed - I don't fully
> > > understand that. Is there a way to preserve that if changes are made
> > > after you sign-off? =20
> >=20
> > Once a tag is given it is up to the patch author to add it to the
> > patches for future versions.  That should only be dropped if the
> > author thinks there are significant enough changes to warrant a fresh
> > review.  If you do drop a tag like that, then the change log
> > under --- on the particular patch should clearly state why. =20
> > >  =20
>=20
> Thanks for the guidance - I see the part I missed:
>=20
>=20
> "Both Tested-by and Reviewed-by tags, once received on mailing list
> from tester or reviewer, should be added by author to the applicable
> patches when sending next versions. However if the patch has changed
> substantially in following version, these tags might not be
> applicable anymore and thus should be removed. Usually removal of
> someone=E2=80=99s Tested-by or Reviewed-by tags should be mentioned in the
> patch changelog (after the =E2=80=98---=E2=80=99 separator)."
>=20
> In my situation I made a mistake by not including his "Reviewed-by"
> in the changes I pushed up. How does this work if no further changes
> are required? Does it call onto the maintainer to apply the tag when
> merging in the change set?
>=20
> Is there anything I should do at this point to correct my error?
It's a slightly messy case but I'd feel fine with a reply that said

oops I forgot to include
Reviewed-by: xxxx
as the scripts will pick that up.
>=20
> Thanks,
> -Sam
>=20
> > > Sorry again about the confusion this caused, =20
> > No problem, takes a while for everyone to get used to a different
> > process. There are extensive docs, but it is still easy to miss
> > things!
> >=20
> > Jonathan
> >  =20
> > > -Sam
> > >  =20
> > > > Best regards,
> > > > Krzysztof
> > > >    =20
> >  =20


