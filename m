Return-Path: <linux-iio+bounces-25412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B424C05217
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37413568101
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BF306B39;
	Fri, 24 Oct 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb772Lkp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19263093B5;
	Fri, 24 Oct 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295030; cv=none; b=eYFGavXSt3AIqqG9O96uOtX21jFXOKvMuQIiRZL+ACEIKDKcKR831mzbbAp0DhNqZhkotMIPapje2Ey9vWNTekYPzg9GSXp2Xea7/575UP6RP5HTjaZCV6oQsOm4ubeQC3L451p2WyPG51PUa3Ch/0hSmoovoP+JUfLVBwshKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295030; c=relaxed/simple;
	bh=JtArdcsAGcyEA/bMgXb5uTz2YbzLj81+yDW1/qVTVzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJwnXMklFWxRv7EgXwGlFBOiLo4fdIfnvFWsvz5E3/HCoET8NqNA0iooP70fIXYHw8RUn2keTQAbuPp/snCydOtpeOqNNLCzztfqF8wZgLBdsFLtKu+B4RFnqFocWLEsdRQr9LTYyBrmQmmDq3xXuaf67jQ71dMRdmd4fih1+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb772Lkp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761295029; x=1792831029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JtArdcsAGcyEA/bMgXb5uTz2YbzLj81+yDW1/qVTVzc=;
  b=mb772LkpFggH+atQsOTbVx6mK62R45P1Yphl1IzzqQ/zUS9kYEsbCzWX
   2BWKo4HR4zQlCtrAX7LVKvJFRQrbm+pRSeUwoNkzPtdbe1pKHearseOVs
   P3Lo2lJWKJDS5U2EStTaJhwbDS6A1sU/1zrxOsrQ3DCGjNGOLZUHcvZJY
   pufrUL63ucjVMatEe47rC3Lkf/C6ckI/CvnM9ld221cQ9niXBmSeQ5mmA
   MjMRBjYhqKWKblPn/GzP0+3J5upTut5X0yxasDZGCzYVN2nw+cUIj/bns
   fpAD2zsvNf87lhBN6o1nM7/OjL/BwKcIC3o+6K5dJzw6Y4CYs7bcv+bCb
   w==;
X-CSE-ConnectionGUID: nKQ0bN8PSu61ycb0YhHbVw==
X-CSE-MsgGUID: gX91Dji9Rt+ix5PxGMEKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504398"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="62504398"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:37:08 -0700
X-CSE-ConnectionGUID: F0C+QL8QTFCiKBQ47eivwA==
X-CSE-MsgGUID: vB8owlCxR7CzMMWA9mVYhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="185152775"
Received: from opintica-mobl1 (HELO ashevche-desk.local) ([10.245.245.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:37:04 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCDID-000000026T5-3koM;
	Fri, 24 Oct 2025 11:37:01 +0300
Date: Fri, 24 Oct 2025 11:37:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <aPs6raLIcM3QbQXJ@smile.fi.intel.com>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
 <aPp5OYcPxNNIOgB6@smile.fi.intel.com>
 <c45309cf-bd2c-41fe-b893-7e0a91de84a8@kernel.org>
 <aPs6HAJabFMRzX9Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPs6HAJabFMRzX9Y@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 11:34:37AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 24, 2025 at 08:18:21AM +0200, Krzysztof Kozlowski wrote:
> > On 23/10/2025 20:51, Andy Shevchenko wrote:
> > > On Sun, Oct 12, 2025 at 05:12:26AM +0200, Krzysztof Kozlowski wrote:
> > >> On 11/10/2025 16:10, Andy Shevchenko wrote:
> > >>> On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

...

> > >>>> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > >>>> +F:     drivers/iio/pressure/adp810.c
> > >>>
> > >>> Some tools will report an orphaned yaml file if you apply patch 1
> > >>> without patch 2.
> > >>
> > >> You mean checkpatch? That warning is not really relevant. Adding
> > >> maintainers entry here for both files is perfectly fine and correct.
> > > 
> > > It's relevant as long as I see (false positive) warnings from it. Can somebody
> > 
> > No, it is not relevant. Just because tool is inefficient does not allow
> > you to point such nitpicks. You as reviewer are supposed to find
> > difference which checkpatch warnings are important and which are not and
> > DO NOT bother contributors with useless points that there is some
> > orphaned file according to checkpatch.
> > 
> > > shut the checkpatch up about missing DT files in the MAINTAINERS?
> > 
> > That would be great but, if no one does it your comments on "orphaned
> > file" are counter productive.
> 
> Something like this?
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6729f18e5654..818b49d314ce 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3441,11 +3441,17 @@ sub process {
>  		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
>  		      (defined($1) || defined($2))))) {
>  			$is_patch = 1;
> -			$reported_maintainer_file = 1;
> -			WARN("FILE_PATH_CHANGES",
> -			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> +			# DT bindings are incorporate maintainer information, no need to report
> +			if ($realfile !~ m@^Documentation/devicetree/bindings/@)) {
> +				$reported_maintainer_file = 1;
> +				WARN("FILE_PATH_CHANGES",
> +				     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> +			}
>  		}

> +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> +			if ($realfile =~ m@^include/asm/@) {

These two lines are leftovers that needs to be removed, of course.

Akhilesh, can you give a try of this change and see if the original DT schema
binding patch is not reported anymore?

>  # Check for adding new DT bindings not in schema format
>  		if (!$in_commit_log &&
>  		    ($line =~ /^new file mode\s*\d+\s*$/) &&

-- 
With Best Regards,
Andy Shevchenko



