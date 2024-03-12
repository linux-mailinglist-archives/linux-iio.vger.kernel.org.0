Return-Path: <linux-iio+bounces-3473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BA879B03
	for <lists+linux-iio@lfdr.de>; Tue, 12 Mar 2024 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9107DB22BA1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Mar 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15921386D8;
	Tue, 12 Mar 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFNV3KHR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68353BE;
	Tue, 12 Mar 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267063; cv=none; b=kE/IhMzJW+rvG0dASWoYd4aHdzfXUWfgSkoN2hyN281HVUmmHKlIn7J65i4V/u5cLGZ71MFbsbXssVusqp0FpryYCQnuHSdj2yzPU4WrjSUzCLZKohYlmyfaxcCGddNRLmDzInYfX+/nUsuF2/KrS0fkqcgF27nunF5jUImIXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267063; c=relaxed/simple;
	bh=iXvp6qLfbM2ZBb4HstqZ7NW7nEQLjt2bZ1lyrtz0h14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcrKESnl9s4orfKmBcexpEkE7whL36c0BzYTDijD6CYBzKWGh31xpKzRKfxu5vDsJrkHWqGDqcvZtDdxSg2OprLyRLBjutRxp1neTpGfWCSlwPMwCLIc5E4lJLCmemz8BqRDXM+X2kZ4BeCTzlZlRZEcGm79c8TCkzjMmg8PaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFNV3KHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF29C433F1;
	Tue, 12 Mar 2024 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267063;
	bh=iXvp6qLfbM2ZBb4HstqZ7NW7nEQLjt2bZ1lyrtz0h14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IFNV3KHRA1kg+FK/m0lc3NwSGSlNtZmVfahkQZv3/dqWUaCV3HiiK6dZzF+r7CJmP
	 ipRBAcPi1pQ0/ejnMiZGPDpJ/MBRGbNSz61FIi1scGnjz7dZICfmE+66kxIQVcR0Tf
	 wAx8YL7sUv7CZzopfOA75Lk/BS6eGn7AZlAETv3pZ3fng6hDspq3xCHH2NF2OXIukN
	 DNV279VgiVgUmVRj3hKWlIcVk/KDNlZWAPJJAvpKymizuuku5QOEIqMNKZQIlldZGv
	 Q6BIbMcqBD10QUo+aEC6TzN5LyJOCeJkKz8UOEDzXTTsHE0pgSPtoswFeQhnCkdXQb
	 eYTruViHenG7w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso990801fa.1;
        Tue, 12 Mar 2024 11:11:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIWBBnD7Nmd1GqvX33JJWSrMoPBtrvAdEFMKFKHEqnNqXNXFlhWWecEi4t80Ok3AtjW7X691R+DY8c1NLljpN5V0OsGzeqKvpT
X-Gm-Message-State: AOJu0YzHhP26oMv4MWvWUwlygg22sFGoTZHVUjvOTuijf7WUTy+Gujv1
	0RzaDZ3IVkg4b7RtHrRglz25EukyoF1oW+GZfVdet/3x57aveDZCF1aUEXprjguf5eeTPcqt/J2
	QO8N2muKMwOgMpu40tZKFsZaZ8w==
X-Google-Smtp-Source: AGHT+IGFIpWi+XnSEBcTESH0jVN7cI01f0pj25ek64QARYYkargkU/fdKRqPF8fouUcSyN19xJtoBKxhjf1St89RWPw=
X-Received: by 2002:a2e:92c3:0:b0:2d4:e6d:ab5b with SMTP id
 k3-20020a2e92c3000000b002d40e6dab5bmr101309ljh.22.1710267061179; Tue, 12 Mar
 2024 11:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225142714.286440-1-jic23@kernel.org> <20240301223942.GA3179769-robh@kernel.org>
 <20240303115633.41128a62@jic23-huawei> <20240309173332.277fce7d@jic23-huawei>
In-Reply-To: <20240309173332.277fce7d@jic23-huawei>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Mar 2024 12:10:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5XaxoL9=urL4ReVv5rhkkti5LN+nFGy1btyO2u7qjEw@mail.gmail.com>
Message-ID: <CAL_JsqJ5XaxoL9=urL4ReVv5rhkkti5LN+nFGy1btyO2u7qjEw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach
 to loops.
To: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	marek.vasut@gmail.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 10:33=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 3 Mar 2024 11:56:33 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Fri, 1 Mar 2024 16:39:42 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Sun, Feb 25, 2024 at 02:27:10PM +0000, Jonathan Cameron wrote:
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Some discussion occured on previous posting.
> > > > https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan.C=
ameron@huawei.com/
> > > >
> > > > Summary:
> > > > * fwnode conversions should be considered when applying this
> > > >   infrastructure to a driver. Perhaps better to move directly to
> > > >   the generic FW property handling rather than improve existing
> > > >   of specific code.
> > > > * There are lots of potential places to use this based on detection=
s
> > > >   from Julia's coccinelle scripts linked below.
> > > >
> > > > The equivalent device_for_each_child_node_scoped() series for
> > > > fwnode will be queued up in IIO for the merge window shortly as
> > > > it has gathered sufficient tags. Hopefully the precdent set there
> > > > for the approach will reassure people that instantiating the
> > > > child variable inside the macro definition is the best approach.
> > > > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@ker=
nel.org/
> > > >
> > > > v2: Andy suggested most of the original converted set should move t=
o
> > > >     generic fwnode / property.h handling.  Within IIO that was
> > > >     a reasonable observation given we've been trying to move away f=
rom
> > > >     firmware specific handling for some time. Patches making that c=
hange
> > > >     to appropriate drivers posted.
> > > >     As we discussed there are cases which are not suitable for such
> > > >     conversion and this infrastructure still provides clear benefit=
s
> > > >     for them.
> > > >
> > > > Ideally it would be good if this introductory series adding the
> > > > infrastructure makes the 6.9 merge window. There are no dependencie=
s
> > > > on work queued in the IIO tree, so this can go via devicetree
> > > > if the maintainers would prefer. I've had some off list messages
> > > > asking when this would be merged, as there is interest in building
> > > > on it next cycle for other parts of the kernel (where conversion to
> > > > fwnode handling may be less appropriate).
> > >
> > > I'll let you take it. For the series:
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > I've got some drivers/of/ conversions too, but they are probably next
> > > cycle at this point.
> > >
> > > Rob
> >
> > Thanks Rob,
> >
> > Whether this makes it for this cycle is probably dependent on whether
> > Linus does decide to do got to rc8 as hinted at as a possibility
> > + whether Greg feels comfortable taking these through his tree
> > (char-misc is the normal path for IIO).  I know various people
> > are hoping this series makes it, but if doesn't we can do an immutable
> > tree early next cycle (though obviously that may reduce speed of adopti=
on).
> >
> > We are discussing the equivalent pull request for the fwnode version he=
re:
> >
> > https://lore.kernel.org/linux-iio/2024030239-gift-cabdriver-266b@gregkh=
/T/#m87e7208820ebf6416a77a2973773b65a087b4796
> >
> > I've optimistically applied this series to my togreg-cleanup branch
> > and merged that into the togreg branch of iio.git for linux-next to pic=
k up.
> >
>
> Greg, would you consider a last minute pull request for these, or picking=
 them up
> directly?  It would be helpful for Rob's follow ups and the work Julia is=
 doing
> with coccinelle and automating of locating cases to apply this approach.
>
> If the device_for_each_child_node_scoped() series is fine this is almostl=
y
> exactly the same thing for the device tree specific case. Not sure what y=
our
> plans are for that pull request so I might be jumping the gun.
>
> If not (and assuming the generic property version does make it in) I'll d=
o
> an immutable branch based on rc1 so that others can build on this via tha=
t.
> Fiddlier solution for everyone but given how late we are, perhaps the wis=
er
> one.

I'm happy to pick up the first 3 patches for 6.9 if you want.

Rob

