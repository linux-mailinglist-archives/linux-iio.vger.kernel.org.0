Return-Path: <linux-iio+bounces-25449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBEEC0C490
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DE374EE5F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A952E7BB2;
	Mon, 27 Oct 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLNoOX+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C758298CAF;
	Mon, 27 Oct 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553462; cv=none; b=Ux28B20xScHtBPwd6lAU0PwxgzybUvdkmV63TAPcrxCBRS7CQRRKs2oGIE0bXPBSv7E3TwA3+FouBwq/eNtiEdigXeKfn1UcUGtqz7HlDbZnfc3CvBFKRdw50jg5YhdRlg2BG4W3+JQrv9ScBmu2M1hZ95HgdgpUDjKXBNl5fV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553462; c=relaxed/simple;
	bh=afxoA2R3pp7UZLkNsvf0Je1PPUIWOpIjbSg/2ArA4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3dt6inTF9wSEhDvW8wdCY+iOMPWYmBlzNPFzhUZieRb79trSfg3uoBCxMKKsW8QwGNDzbhjLYpej3b8vae2sZl0l45lb2wFIgvy2TK1Ef5HNhzD+hNJEyabeRtyojWVIueVedKdAM1j294RycHKlhuHyBHWJoFH97wYmJ8XmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLNoOX+4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761553461; x=1793089461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=afxoA2R3pp7UZLkNsvf0Je1PPUIWOpIjbSg/2ArA4gk=;
  b=nLNoOX+4A4lf14T2eyP5eiaSuc+i9RlufGa+DH19InT3f6Aqjw6RlfRb
   SkmLpznMqOQMkl90VGXmbUnlsnMTAMRAZFkagkmfHtYrU2AWjmifemD4A
   3lZENMEycoxsU0ENL3n76tQ51VlwnrARk6qBXYoKk5vGj0xR7ydvGEkj1
   GsAQ6cReuPeAXvooNiOXHC3qbvlpON3i14j0negEPQvLZ8BB96zQAsHVJ
   K1G0Zy+VwdADBoTuGN/wKwBMFIDo0bfpgaqOxDLHDz4hYYfJjkPMLyxW3
   +mzjUGkK9b2f/TZ1bPMON4N/sHdRECPpCiGb/nL4cuf3xjV6a/A2uFAVT
   A==;
X-CSE-ConnectionGUID: 94+CRYqRT9ONf2CbzRIkNQ==
X-CSE-MsgGUID: /CgqhPJASS6S/1ITFIen5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67492743"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="67492743"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:24:20 -0700
X-CSE-ConnectionGUID: 5/T+k/cZQ4ecNxs3upHIZQ==
X-CSE-MsgGUID: EZUyz3g6Tdua69OIn3lUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184600927"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:24:16 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDIWT-00000002wmB-26t2;
	Mon, 27 Oct 2025 10:24:13 +0200
Date: Mon, 27 Oct 2025 10:24:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <aP8sLeR7eTBntozI@smile.fi.intel.com>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
 <aPp5OYcPxNNIOgB6@smile.fi.intel.com>
 <c45309cf-bd2c-41fe-b893-7e0a91de84a8@kernel.org>
 <aPs6HAJabFMRzX9Y@smile.fi.intel.com>
 <aPs6raLIcM3QbQXJ@smile.fi.intel.com>
 <20251024-175010-876729@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024-175010-876729@bhairav-test.ee.iitb.ac.in>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 11:20:10PM +0530, Akhilesh Patil wrote:
> On Fri, Oct 24, 2025 at 11:37:01AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 24, 2025 at 11:34:37AM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 24, 2025 at 08:18:21AM +0200, Krzysztof Kozlowski wrote:
> > > > On 23/10/2025 20:51, Andy Shevchenko wrote:
> > > > > On Sun, Oct 12, 2025 at 05:12:26AM +0200, Krzysztof Kozlowski wrote:
> > > > >> On 11/10/2025 16:10, Andy Shevchenko wrote:
> > > > >>> On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

...

> > > > >>>> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > > >>>> +F:     drivers/iio/pressure/adp810.c
> > > > >>>
> > > > >>> Some tools will report an orphaned yaml file if you apply patch 1
> > > > >>> without patch 2.
> > > > >>
> > > > >> You mean checkpatch? That warning is not really relevant. Adding
> > > > >> maintainers entry here for both files is perfectly fine and correct.
> > > > > 
> > > > > It's relevant as long as I see (false positive) warnings from it. Can somebody
> > > > 
> > > > No, it is not relevant. Just because tool is inefficient does not allow
> > > > you to point such nitpicks. You as reviewer are supposed to find
> > > > difference which checkpatch warnings are important and which are not and
> > > > DO NOT bother contributors with useless points that there is some
> > > > orphaned file according to checkpatch.
> > > > 
> > > > > shut the checkpatch up about missing DT files in the MAINTAINERS?
> > > > 
> > > > That would be great but, if no one does it your comments on "orphaned
> > > > file" are counter productive.
> > > 
> > > Something like this?
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 6729f18e5654..818b49d314ce 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3441,11 +3441,17 @@ sub process {
> > >  		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> > >  		      (defined($1) || defined($2))))) {
> > >  			$is_patch = 1;
> > > -			$reported_maintainer_file = 1;
> > > -			WARN("FILE_PATH_CHANGES",
> > > -			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > > +			# DT bindings are incorporate maintainer information, no need to report
> > > +			if ($realfile !~ m@^Documentation/devicetree/bindings/@)) {
> > > +				$reported_maintainer_file = 1;
> > > +				WARN("FILE_PATH_CHANGES",
> > > +				     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > > +			}
> > >  		}
> > 
> > > +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > +			if ($realfile =~ m@^include/asm/@) {
> > 
> > These two lines are leftovers that needs to be removed, of course.
> > 
> > Akhilesh, can you give a try of this change and see if the original DT schema
> > binding patch is not reported anymore?
> 
> Hi Andy. I tested checkpatch.pl patch you suggested here. checkpatch
> does NOT show the warning now on my dt-bindings patch. Thanks for
> initiating this script improvement.
> I believe this is kernel wide script improvement and best to take
> independently if I understood correctly.

Definitely. May I use your Tested-by tag?

> > >  # Check for adding new DT bindings not in schema format
> > >  		if (!$in_commit_log &&
> > >  		    ($line =~ /^new file mode\s*\d+\s*$/) &&

-- 
With Best Regards,
Andy Shevchenko



