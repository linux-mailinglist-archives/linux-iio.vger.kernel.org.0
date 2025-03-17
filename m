Return-Path: <linux-iio+bounces-16970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F2A65512
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C34D3B1F90
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05932459E9;
	Mon, 17 Mar 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="lxrKEwQf"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459B2236FD;
	Mon, 17 Mar 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224075; cv=none; b=UonN6Wdfy4CoinzlDGzfhROkpJ9bqIeLYZWV7hV7IxTKqxr2XqMlJ0NQ7+eNAyRNobJgFGD9XYoNOrpyAYJPDzo//iceBTbKHPeQkWvpEwlY0VC2r9FAIOCf3ubvXs7/I6USYKAp6P7ZRSN/B/MFBNgdRQJ+XWIXNSfe+t7rk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224075; c=relaxed/simple;
	bh=BpY9UtFe+O2yT1YzwOQ8IV9Bn6Cu3YlhgV1pKejLnRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+t9/dSy7AQYKrWZNG6fqY17FywFvmAEwCx94ebw8n5yDyCGnStpxUkUsaRuAjdKJON8Ebsn48frMQD31gwlOseWsqDT1HRGeUfWPetuSFv41kakI1W0/H/h9TvVGgF1a2OyKZXXIWj7FYI4qPodvxQw3XHQO4Sj1Bb4j05reEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=lxrKEwQf; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZGdcy44xLz3xRV;
	Mon, 17 Mar 2025 15:07:46 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZGdcy3ccYz2Sd0R;
	Mon, 17 Mar 2025 11:07:46 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZGdcy26Ndz3hhW5;
	Mon, 17 Mar 2025 11:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742224066;
	bh=BpY9UtFe+O2yT1YzwOQ8IV9Bn6Cu3YlhgV1pKejLnRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxrKEwQf87N1KBGepFpyL6lQSLFNPT8rgcmtOLqJi+v2uZ+CbNAtymnCkKTk4isWx
	 b8IqakvyZtTRZkb3f91xwK+GXJFeQHvWNGN3L58gbLRtTGxgQqFMByjzn9T/bhxJC+
	 PLlCGtDmqX/GMn13kN8kErJb779jKvraEyjfXJE7Ezy3n0fZxabt1DppZRvNyor95O
	 kH5/sTh5bvGCihS/6DKE4SXJAzhK0QMkCbDGsGCbN0qrW7ICNTEl4ovP0kaJuMlWQA
	 mW2aN64hdoOkh7zHfHXZE4M0HM8oor/MvssEa3pG6rMt9YESuwt+2oJP9/6GVezOKZ
	 Kn6T5nD1wxt0A==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Mon, 17 Mar 2025 11:07:31 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:07:32 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z9g6tPqhAoTckFBh@65YTFL3.secure.tethers.com>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
 <20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sun, Mar 16, 2025 at 05:38:42PM +0100, Krzysztof Kozlowski wrote:
> On Sun, Mar 16, 2025 at 09:50:03AM -0400, Sam Winchenbach wrote:
> > From: Sam Winchenbach <swinchenbach@arka.org>
> > 
> > Adds two properties to add a margin when automatically finding the
> > corner frequencies.
> > 
> > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > ---
> >  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> I don't understand. You got my tag. No changelog here, no cover letter,
> nothing explains what happened here and why the tag is being removed.
> 

Apologies,

I am still quite new to this workflow, and it deviates significantly
from my day-to-day work. I mentioned in the previous patch set that I
would like to update my email address and change:
"driver core: -> iio: core:"
I wasn't aware more than that was needed. Sorry for any confusion
this may have caused.

In the future what is the preferred way to handle a
situation like this? I wasn't aware of the cover letter feature but
that looks like a promising option.

It looks like another option is to add commentary to each patch.

I am less certain about your tag being removed - I don't fully
understand that. Is there a way to preserve that if changes are made
after you sign-off?

Sorry again about the confusion this caused,
-Sam

> Best regards,
> Krzysztof
> 

