Return-Path: <linux-iio+bounces-2056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC7842E42
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 21:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069D9B23269
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369669E1B;
	Tue, 30 Jan 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjmomNK5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108179DD6;
	Tue, 30 Jan 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648043; cv=none; b=F9Yku4XCb2n7WwgNyE3RWDkKaa1aU634WX2Qx/bKaZEzpxRVBW2FsceEKjxBgNRgoMfCUtf3sN0fVJHEsAN2E4C5A+zw0FEptVpFuEWGRPbASR6EV5cP71inLRjnN3KDUaheEjc8PJnAc6jvyb7PYByXsCkB85DVcSOks7af6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648043; c=relaxed/simple;
	bh=mAvKGxIVUW1g+mfST20NmOOEIRkeO+/JyLuN+KAZgQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlT8DhFdLEZU8bmINjcLMoE7alw7NW2J3xz0GKV94iv3inj3FPu/5Wy3fx55qLBNbhfKkCB1fHKRcsZqd/JKkbUSp7cbDDqg6epVs/pbXUsXy2ZZXI9Saji1yONwNJSQ6zMWscBfx3i9kO+8qyDLyWDCFXQN7wCrTsO4vgcWXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjmomNK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34729C433C7;
	Tue, 30 Jan 2024 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706648042;
	bh=mAvKGxIVUW1g+mfST20NmOOEIRkeO+/JyLuN+KAZgQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjmomNK5TgEF5eJg5YdmsVUzPGtMztCeSO53Z9RbuDVycF5rShF9XkNsVYGfcmsoI
	 ERPpMORy2WSqOkQfWUY6lGuih1POzUnf3F25JfRKBm8Lezi5T94NqLOvhzauoQ4e97
	 ErG8jWFrAKb4HJ9hJSEtoNEqqS2SU2N5n5pjHtikQ9bxF4W1qQMBfbAF6Io7I5qy7f
	 rZDRClHfloenMpDBaMVgE/KH8dFE4NEqAnYwdxC2LzazMyp3Z06oVDEzSjifROb9uk
	 8h1VA420PLhI4EprF4c1MYO2myKBAyPzTTzC5OyHBrCDfttdE1ZwHqjvSN6MiQ9eEi
	 Bpzzqvhw2sRjA==
Date: Tue, 30 Jan 2024 14:54:00 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
Message-ID: <20240130205400.GA2319582-robh@kernel.org>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
 <CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
 <20240127150726.3c9150c7@jic23-huawei>
 <dbf75dfff3ac2d03d198de918a6c525f7b5266c6.camel@gmail.com>
 <CAGETcx-_FbMuisXb5aw40RxgnMT8xTOaq2FOmTo-twY09EV1sQ@mail.gmail.com>
 <c15cff6c67a9cbb9dc191175cb550ef28639c252.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c15cff6c67a9cbb9dc191175cb550ef28639c252.camel@gmail.com>

On Tue, Jan 30, 2024 at 11:32:00AM +0100, Nuno Sá wrote:
> On Mon, 2024-01-29 at 14:33 -0800, Saravana Kannan wrote:
> > On Mon, Jan 29, 2024 at 12:15 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > 
> > > On Sat, 2024-01-27 at 15:07 +0000, Jonathan Cameron wrote:
> > > > On Wed, 24 Jan 2024 19:14:35 -0800
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > 
> > > > > On Tue, Jan 23, 2024 at 7:14 AM Nuno Sa via B4 Relay
> > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > > 
> > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > 
> > > > > > The property is io-channels and not io-channel. This was effectively
> > > > > > preventing the devlink creation.
> > > > 
> > > > I'm a bit lost on the devlink side of things. Is this something with
> > > > effects on existing drivers before this patch set, or is it only causing
> > > > real problems with the changes in here?
> > > > 
> > > > i.e. Should we mark it for stable and rush it in as a fix, or can it wait
> > > > for the rest of the set?
> > > > 
> > > 
> > > I guess you already figured this out? Anyways, this is a real fix that was
> > > affecting any consumer using io-channels (so nothing to do with the current
> > > series). Since the there was a typo, no fw_links were being created.
> > > 
> > > I stated in the cover why I included this. Just to make the addition of io-
> > > backends later on easier. But if Rob prefers (or you), I can just send this
> > > standalone patch to the devicetree list.
> > 
> > I think you should send this to Rob directly as a DT fix. I already
> > gave you a Reviewed-by too. So it should land quickly.
> > 
> > This is a real bug that we want to fix as soon as we can. And your
> > series might take a bit longer to land.
> > 
> > -Saravana
> 
> Alright... will do that

No need to resend. I'll apply this one.

Rob


