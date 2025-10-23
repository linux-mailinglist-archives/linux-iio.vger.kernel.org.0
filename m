Return-Path: <linux-iio+bounces-25398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F038C03166
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D235D3A2C34
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B534BA32;
	Thu, 23 Oct 2025 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE8W/9c1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D734B681;
	Thu, 23 Oct 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245506; cv=none; b=dW9pPEt5KUIUe22r6uQI4hNvadsk5NMXT1ohLgebH+S+xFTSNvjPRlT76SkobeEEh5HWfMnTmxlxgfhv+LA+gks7fu5OdYL0xN6fYhj3MuR2GZ1gEUJ1ZGsyl2VmAhHUu/rzOTTu7F4SrtCKrRctBRJlF+OTaGvsvJcmFWa1AiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245506; c=relaxed/simple;
	bh=w1wstypz6XgiBOEHNrlo+bizf5VavPX2yq4PjU9XYyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nysdQRUaaa60Bo7N8s5qQSS9ilk6ROV1V2UIEn/DOdsEpEeXzUhzkI0i9PiZbqgYIFFMWiFNj2f/M/7iyNjmIkrLMJwQkC97VHIDHOxmSoVFuDJnCmMyk9U8g1aOzMyODy/PCW0+b8Pbw6yxGknYM97XRtGN9k6ItwTSS/OuTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE8W/9c1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761245505; x=1792781505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w1wstypz6XgiBOEHNrlo+bizf5VavPX2yq4PjU9XYyA=;
  b=mE8W/9c1uLzqOwEl0XbEojvymmG6Oz6q2prFpm+DW49dBuRGPHWrhRwj
   GSMqweTeVhFjX7uPfaAAomd86IiemqQCKtUTa9zHChwa+haopInzJ4H0l
   pAMvtk/ImbVkNTZEchSdvcZp///jwH1ERn78y9uvO+QcjD9OPbrWmOVdU
   3//BcjVXRzjn8MQ//9rnXRupg8QqY+PJPhPkCipzk6sGLlLEUiv5bPwxH
   J7fYHXv4GfDXM4nE6TAXiGIXMm/cB6jDzpl/2zckLzjMwUAa8RPRJqZO1
   mnwGj+S8TmPxD+tbrd+TlzaIDfTlPcU2DWJH6DdsIjzR8keYL4tRqgfh6
   g==;
X-CSE-ConnectionGUID: OYPs6oIvROO9GLr5/lENyw==
X-CSE-MsgGUID: xbYiqSUJSBi8ZCTGYS+R2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66041427"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="66041427"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:51:44 -0700
X-CSE-ConnectionGUID: UPoG+fY6SY2BObKguIsuYw==
X-CSE-MsgGUID: Y4HygLLIRsKI7KPxF+AZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184712791"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:51:40 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vC0PR-0000000210x-3Zih;
	Thu, 23 Oct 2025 21:51:37 +0300
Date: Thu, 23 Oct 2025 21:51:37 +0300
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
Message-ID: <aPp5OYcPxNNIOgB6@smile.fi.intel.com>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95c1ba99-510b-4efb-9b6d-4c1103fc43a5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 12, 2025 at 05:12:26AM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2025 16:10, Andy Shevchenko wrote:
> > On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> >> +AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> >> +M:     Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> >> +L:     linux-iio@vger.kernel.org
> >> +S:     Maintained
> >> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> >> +F:     drivers/iio/pressure/adp810.c
> > 
> > Some tools will report an orphaned yaml file if you apply patch 1
> > without patch 2.
> 
> You mean checkpatch? That warning is not really relevant. Adding
> maintainers entry here for both files is perfectly fine and correct.

It's relevant as long as I see (false positive) warnings from it. Can somebody
shut the checkpatch up about missing DT files in the MAINTAINERS?

-- 
With Best Regards,
Andy Shevchenko



