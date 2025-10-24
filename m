Return-Path: <linux-iio+bounces-25427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5792C07956
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 19:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BAF189FF33
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9600343209;
	Fri, 24 Oct 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="kspQttvv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE9335093
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328234; cv=none; b=aBBPZMDzfsYlpA5w1LP9wgElDp8a6EizNnflHj4vonWBf/UQ+0bApAGkjyQ6pIZmFOPIEe2i8Nzu+MXraAan2SUoX7upTofEUZFtL7btvHgZQKTnW0IlTx/IJIte9PGGjcV/IxTxEGT382SxDnQKsGj4pNMCP0x5KxILLtujT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328234; c=relaxed/simple;
	bh=8qAR75JaH4mfH/My4QWqcxLHgY+ysFJl6KwuNGwLdMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwaemUT4e4KuYPkxirSCi8EVRPrmWO21LH9zyTqu1Bl6LI8p5Uolzf+D8Bo16F0BJk2RzylQpmhO59QhCCIYnZAL7VhY/kDJK5jjKh3siBlGSsJRE6QyXpyc/1k0qrdSpCT/+AYG//ctSx7ftTZdv62pXHpmEFcX7SNUlbKq404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=kspQttvv; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 1DD2D104C1F9
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 23:20:20 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 1DD2D104C1F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761328220; bh=8qAR75JaH4mfH/My4QWqcxLHgY+ysFJl6KwuNGwLdMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kspQttvvSziCmmRXrxP7mW6eNaCxwso9OF7lTCOO/hBQ+tVBK+MDq3w7cOCPOIzBu
	 y84LXezttbplIUEDIzoVG/+QzCMNVjG67OT4pHLaX9ocgD6VK6jsmBzP1/+cYxOHRg
	 zfNm9CEUXwOJ9reEX/4mgGKSa4+u3olUMpoOcJ50=
Received: (qmail 28386 invoked by uid 510); 24 Oct 2025 23:20:20 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.480435 secs; 24 Oct 2025 23:20:20 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 24 Oct 2025 23:20:16 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id A1A2E34150E;
	Fri, 24 Oct 2025 23:20:15 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 644D11E815D7;
	Fri, 24 Oct 2025 23:20:15 +0530 (IST)
Date: Fri, 24 Oct 2025 23:20:10 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <20251024-175010-876729@bhairav-test.ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
 <aPp5OYcPxNNIOgB6@smile.fi.intel.com>
 <c45309cf-bd2c-41fe-b893-7e0a91de84a8@kernel.org>
 <aPs6HAJabFMRzX9Y@smile.fi.intel.com>
 <aPs6raLIcM3QbQXJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPs6raLIcM3QbQXJ@smile.fi.intel.com>

On Fri, Oct 24, 2025 at 11:37:01AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 24, 2025 at 11:34:37AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 24, 2025 at 08:18:21AM +0200, Krzysztof Kozlowski wrote:
> > > On 23/10/2025 20:51, Andy Shevchenko wrote:
> > > > On Sun, Oct 12, 2025 at 05:12:26AM +0200, Krzysztof Kozlowski wrote:
> > > >> On 11/10/2025 16:10, Andy Shevchenko wrote:
> > > >>> On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> 
> ...
> 
> > > >>>> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > >>>> +F:     drivers/iio/pressure/adp810.c
> > > >>>
> > > >>> Some tools will report an orphaned yaml file if you apply patch 1
> > > >>> without patch 2.
> > > >>
> > > >> You mean checkpatch? That warning is not really relevant. Adding
> > > >> maintainers entry here for both files is perfectly fine and correct.
> > > > 
> > > > It's relevant as long as I see (false positive) warnings from it. Can somebody
> > > 
> > > No, it is not relevant. Just because tool is inefficient does not allow
> > > you to point such nitpicks. You as reviewer are supposed to find
> > > difference which checkpatch warnings are important and which are not and
> > > DO NOT bother contributors with useless points that there is some
> > > orphaned file according to checkpatch.
> > > 
> > > > shut the checkpatch up about missing DT files in the MAINTAINERS?
> > > 
> > > That would be great but, if no one does it your comments on "orphaned
> > > file" are counter productive.
> > 
> > Something like this?
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 6729f18e5654..818b49d314ce 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3441,11 +3441,17 @@ sub process {
> >  		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> >  		      (defined($1) || defined($2))))) {
> >  			$is_patch = 1;
> > -			$reported_maintainer_file = 1;
> > -			WARN("FILE_PATH_CHANGES",
> > -			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > +			# DT bindings are incorporate maintainer information, no need to report
> > +			if ($realfile !~ m@^Documentation/devicetree/bindings/@)) {
> > +				$reported_maintainer_file = 1;
> > +				WARN("FILE_PATH_CHANGES",
> > +				     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > +			}
> >  		}
> 
> > +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > +			if ($realfile =~ m@^include/asm/@) {
> 
> These two lines are leftovers that needs to be removed, of course.
> 
> Akhilesh, can you give a try of this change and see if the original DT schema
> binding patch is not reported anymore?

Hi Andy. I tested checkpatch.pl patch you suggested here. checkpatch
does NOT show the warning now on my dt-bindings patch. Thanks for
initiating this script improvement.
I believe this is kernel wide script improvement and best to take
independently if I understood correctly.

Regards,
Akhilesh

> 
> >  # Check for adding new DT bindings not in schema format
> >  		if (!$in_commit_log &&
> >  		    ($line =~ /^new file mode\s*\d+\s*$/) &&
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

