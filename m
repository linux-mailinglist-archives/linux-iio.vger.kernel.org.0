Return-Path: <linux-iio+bounces-25411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47805C051DF
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA3424029
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3392556E;
	Fri, 24 Oct 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/b5/0lV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6C23505E;
	Fri, 24 Oct 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294886; cv=none; b=utKtKfTJH0KtsuFBPh0Jgb+cJiEhGH6xP1Wply+gmLYPiH8/Aucg6y107hYmtuptGxOs1csetcCcO9ZgrrXY8KbKcc5BLseJjo5fW9gQs+jShbSXtA8JRye3KwDjn5kYPZ8nWOqiXBQyYsESKFEJkJr/s7l1/2QkSTtCk5FtN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294886; c=relaxed/simple;
	bh=3wJ2Lm1NIoSCDLTsAVQJX6UqwGAnmGS9C+643NMAYNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywzj6nSr+phNaaGUQXZ7yfpB09wH45EMxIQuUhLXq9QXVtPbUTJErnrVDpD0p9jRhEBDc3eiNJXYG1mh9DMxjrGrARA998fJoxx/qiYfcv0DLFU/qi7uuwF30OdLVn8s6a7JdXaEGjT37Gd9q+mpPGbWA6eYV0j+Yu6jx3JeVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/b5/0lV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761294885; x=1792830885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3wJ2Lm1NIoSCDLTsAVQJX6UqwGAnmGS9C+643NMAYNI=;
  b=E/b5/0lV6tt7in78lLM6i6r+kP+jCvYzoSCswtWu9TuIbr6607sce+O4
   PBka1yfdBhCMO3CXob+Ccz38YPkfOdrehMsSreRWpfJr7pwblDIluIoqV
   Nyyl8UVPbxBQ2ZAHsejN+TcH44rl9D7kqn0mwRKXUrUmpd7GhqOtW48gU
   jCjHl8I0qgNnhigAspFXa23AmHEzs0tDyLlYJqaL5cLUb+m4XSY1mNbkc
   dSsgRczLLMo+ntyas/6enLqxrrAyGESoA0oyWVeizzr01P35EgC/GvrZg
   5LQmFUtGQZ6L8WVNU9hiDh1jpgXFB0okn95xksRs9Ou1CGdrGf/Wx5l5U
   w==;
X-CSE-ConnectionGUID: qHHBSEEHTruT+3gcfU2sqQ==
X-CSE-MsgGUID: DFrQJhQRRqOAjnC4awNiFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88942487"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="88942487"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:34:44 -0700
X-CSE-ConnectionGUID: Y5r7aiH2R9mACMQwYNXBiQ==
X-CSE-MsgGUID: vhyhBaQCRQG5ah/G/ZxqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184447255"
Received: from opintica-mobl1 (HELO ashevche-desk.local) ([10.245.245.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:34:40 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCDFt-000000026S8-0XNu;
	Fri, 24 Oct 2025 11:34:37 +0300
Date: Fri, 24 Oct 2025 11:34:36 +0300
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
Message-ID: <aPs6HAJabFMRzX9Y@smile.fi.intel.com>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
 <aPp5OYcPxNNIOgB6@smile.fi.intel.com>
 <c45309cf-bd2c-41fe-b893-7e0a91de84a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c45309cf-bd2c-41fe-b893-7e0a91de84a8@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 08:18:21AM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2025 20:51, Andy Shevchenko wrote:
> > On Sun, Oct 12, 2025 at 05:12:26AM +0200, Krzysztof Kozlowski wrote:
> >> On 11/10/2025 16:10, Andy Shevchenko wrote:
> >>> On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> >>>> +AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> >>>> +M:     Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> >>>> +L:     linux-iio@vger.kernel.org
> >>>> +S:     Maintained
> >>>> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> >>>> +F:     drivers/iio/pressure/adp810.c
> >>>
> >>> Some tools will report an orphaned yaml file if you apply patch 1
> >>> without patch 2.
> >>
> >> You mean checkpatch? That warning is not really relevant. Adding
> >> maintainers entry here for both files is perfectly fine and correct.
> > 
> > It's relevant as long as I see (false positive) warnings from it. Can somebody
> 
> 
> No, it is not relevant. Just because tool is inefficient does not allow
> you to point such nitpicks. You as reviewer are supposed to find
> difference which checkpatch warnings are important and which are not and
> DO NOT bother contributors with useless points that there is some
> orphaned file according to checkpatch.
> 
> 
> > shut the checkpatch up about missing DT files in the MAINTAINERS?
> 
> That would be great but, if no one does it your comments on "orphaned
> file" are counter productive.

Something like this?

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6729f18e5654..818b49d314ce 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3441,11 +3441,17 @@ sub process {
 		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
 		      (defined($1) || defined($2))))) {
 			$is_patch = 1;
-			$reported_maintainer_file = 1;
-			WARN("FILE_PATH_CHANGES",
-			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			# DT bindings are incorporate maintainer information, no need to report
+			if ($realfile !~ m@^Documentation/devicetree/bindings/@)) {
+				$reported_maintainer_file = 1;
+				WARN("FILE_PATH_CHANGES",
+				     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			}
 		}
 
+		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
+			if ($realfile =~ m@^include/asm/@) {
+
 # Check for adding new DT bindings not in schema format
 		if (!$in_commit_log &&
 		    ($line =~ /^new file mode\s*\d+\s*$/) &&

-- 
With Best Regards,
Andy Shevchenko



