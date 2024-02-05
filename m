Return-Path: <linux-iio+bounces-2189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40A849C46
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CDC1C2405A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE4210F0;
	Mon,  5 Feb 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOq2x8rK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CC249FA;
	Mon,  5 Feb 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141255; cv=none; b=kvxlHB2uPF15hqKS99VwMb1wGexa68eHWJ9uUB2lJsGPD/E3WXbbhteUqhICLGP0EUqBr7dtXWcslB2l2Z0S21yy9RKqGM9vk9+Lbxsk9h7M2JLlEYCKdeiprJE2nrNBRn2fiOxHXF2be+Urf+ELHPqy50zKjP04/2CEfyr5lYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141255; c=relaxed/simple;
	bh=ByjGRKIAxB+anNz3m5q4sI+W1Mu2k8bRZPpufOgGAk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqSBm9DBxpeVTT25YaOu8cL/v+AX4gIZe9CqKYKqQlxgCyw+y4yVCQXVUp+rvTGhY5DENTAG+/mBIS01QxZ3ue3CwCooUbvkrC8vuOuil02ZSIw3DrLOTzaUDKqvaq3A5m1W0l7Rgz4YnESDZjG28UVKJJvAB44fmm1DONTM2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOq2x8rK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141253; x=1738677253;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ByjGRKIAxB+anNz3m5q4sI+W1Mu2k8bRZPpufOgGAk0=;
  b=nOq2x8rKmdNqMNkWPJSag782REVfHvQBuwGy6XGc4b1gPQN5RpoR4VjV
   jXjg06R55p4KYHXmSMDPizvaTv1Pl0+1Wt2bWsTat1DISrjgEyykTFIsU
   txmpkLjYIpSvSFyQsWQkEvAgR1UTk9e3+L2W8m84MJrrlC2xG2ad8YVJs
   D7dMz3E6sFWvwKwMusM/p6KL9yqxkA0aaPzLWD7YxE6qMBHbgIiKY2uM7
   5h6rP/Kphntv2h8qs/DmVNmzoosU8Pkz31JKWxZAlV2oL+UsklRFC9n+y
   iFxpJ94fHAjWmKwScc4lihzFIpihAj0G1E5w0w8WSIdnNxtzVHeCBpovd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="413669"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="413669"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="728739"
Received: from arulkumx-mobl2.gar.corp.intel.com (HELO [10.212.78.185]) ([10.212.78.185])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:54:12 -0800
Message-ID: <82d941588151c82731dcfa9558908d7deb1052e7.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/4] iio: hid-sensor-als: Assign channels dynamically
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 05 Feb 2024 08:54:10 -0500
In-Reply-To: <20240204155839.3dd1d639@jic23-huawei>
References: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
	 <20240204130332.2635760-2-srinivas.pandruvada@linux.intel.com>
	 <20240204155839.3dd1d639@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSm9udGFoYW4sCgpPbiBTdW4sIDIwMjQtMDItMDQgYXQgMTU6NTggKzAwMDAsIEpvbmF0aGFu
IENhbWVyb24gd3JvdGU6Cj4gT24gU3VuLMKgIDQgRmViIDIwMjQgMDU6MDM6MjkgLTA4MDAKPiBT
cmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4g
d3JvdGU6Cj4gCj4gPiBJbnN0ZWFkIG9mIGFzc3VtaW5nIHRoYXQgZXZlcnkgY2hhbm5lbCBkZWZp
bmVkIHN0YXRpY2FsbHkgYnkKPiA+IGFsc19jaGFubmVsc1tdIGlzIHByZXNlbnQsIGFzc2lnbiBk
eW5hbWljYWxseSBiYXNlZCBvbiBwcmVzZW5jZSBvZgo+ID4gdGhlCj4gPiByZXNwZWN0aXZlIHVz
YWdlIGlkIGluIHRoZSBkZXNjcmlwdG9yLiBUaGlzIHdpbGwgYWxsb3cgdG8gcmVnaXN0ZXIKPiA+
IEFMUwo+ID4gd2l0aCBsaW1pdGVkIGNoYW5uZWwgc3VwcG9ydC4gQXBwZW5kIHRoZSB0aW1lc3Rh
bXAgYXMgdGhlIGxhc3QKPiA+IGNoYW5uZWwuCj4gPiAKPiA+IFVwZGF0ZSBhdmFpbGFibGVfc2Nh
bl9tYXNrIHRvIHNwZWNpZnkgYWxsIGNoYW5uZWxzIHdoaWNoIGFyZQo+ID4gcHJlc2VudC4KPiA+
IAo+ID4gVGhlcmUgaXMgbm8gaW50ZW50aW9uYWwgZnVuY3Rpb24gY2hhbmdlcyBkb25lLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhCj4gPiA8c3Jpbml2YXMucGFu
ZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Cj4gSGkgU3Jpbml2YXMsCj4gCj4gTG9naWMgbG9va3Mg
ZmluZSwgYnV0IG5vdCB0aGF0IGdsb2JhbCB2YXJpYWJsZS4uLgpUaGlzIHdpbGwgYmUgYSBwcm9i
bGVtIHdpdGggbXVsdGlwbGUgaW5zdGFuY2VzIHdpdGggZGlmZmVyZW50CmNvbWJpbmF0aW9uLiBB
bHRob3VnaCBub3Qgc2VlbiBpbiBjdXJyZW50IGRldmljZXMsIGJ1dCB0aGlzIGlzCnBvc3NpYmxl
LgpTbyB3aWxsIHNlbmQgYW4gdXBkYXRlLgoKVGhhbmtzLApTcmluaXZhcwoKPiAKCj4gPiAtLS0K
PiA+IHY0Ogo+ID4gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gSm9udGhhbjoKPiA+IMKgwqDCoMKg
wqDCoMKgwqAtIFVzZSBhdmFpbGFibGVfc2Nhbl9tYXNrcwo+ID4gwqDCoMKgwqDCoMKgwqDCoC0g
dGltZXN0YW1wIGxvY2F0aW9uIGlzIGZpeGVkIGFuZCBsZWZ0IGdhcHMgaW4gc2FtcGxlIGRhdGEK
PiA+IGZvciBhYnNlbnQgY2hhbm5lbHMKPiA+IMKgwqDCoMKgwqDCoMKgwqAtIFVzZSBDSEFOTkVM
X1NDQU5fSU5ERVhfTUFYIGFzIGxpbWl0IHRvIGNoZWNrIHByZXNlbmNlIG9mCj4gPiB1c2FnZSBp
ZHMsIG90aGVyd2lzZQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGl0IHdpbGwgbWlzcyBuZXdlciBj
aGFubmVscyBhZGRlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4gPiB2MzoKPiA+IEFkZHJlc3Nl
ZCBjb21tZW50cyBmcm9tIEpvbnRoYW46Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLSBSZW1vdmUgY2hh
bm5lbCBhbGxvY2F0aW9uIGFuZCBtb3ZlIHRvIGlpb19wcml2KCkKPiA+IMKgwqDCoMKgwqDCoMKg
wqAtIFBhcnNlIGFsbCB1c2FnZSBJRHMgaW4gYSBzaW5nbGUgbG9vcCBhbmQgY29udGludWUKPiA+
IMKgwqDCoMKgwqDCoMKgwqBmb3IgZmFpbHVyZS4gVGhpcyB3YXkgdGhlIHRlbXBlcmF0dXJlIGFu
ZCBjaHJvbWF0aWNpdHkKPiA+IMKgwqDCoMKgwqDCoMKgwqB3aWxsIG5vdCBuZWVkIGFueSBzcGVj
aWFsIHByb2Nlc3NpbmcgdG8gcGFyc2UgdXNhZ2UgaWRzLgo+ID4gwqDCoMKgwqDCoMKgwqDCoC0g
RG9uJ3QgbGVhdmUgZW1wdHkgY2hhbm5lbCBpbmRleGVzCj4gPiAKPiA+IHYyOgo+ID4gTmV3IGNo
YW5nZQo+ID4gCj4gPiDCoGRyaXZlcnMvaWlvL2xpZ2h0L2hpZC1zZW5zb3ItYWxzLmMgfCA1MiAr
KysrKysrKysrKysrKysrKysrKystLS0tLQo+ID4gLS0tLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MzYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLWFscy5jCj4gPiBiL2RyaXZlcnMvaWlvL2xpZ2h0
L2hpZC1zZW5zb3ItYWxzLmMKPiA+IGluZGV4IGI2YzRiZWYyYTdiYi4uZDNiODkyYzBlMzA3IDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1hbHMuYwo+ID4gKysr
IGIvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1hbHMuYwo+ID4gQEAgLTI1LDYgKzI1LDcg
QEAgc3RydWN0IGFsc19zdGF0ZSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGhpZF9zZW5z
b3JfaHViX2NhbGxiYWNrcyBjYWxsYmFja3M7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGhp
ZF9zZW5zb3JfY29tbW9uIGNvbW1vbl9hdHRyaWJ1dGVzOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBoaWRfc2Vuc29yX2h1Yl9hdHRyaWJ1dGVfaW5mbwo+ID4gYWxzW0NIQU5ORUxfU0NBTl9J
TkRFWF9NQVhdOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlpb19jaGFuX3NwZWMgY2hhbm5l
bHNbQ0hBTk5FTF9TQ0FOX0lOREVYX01BWCArIDFdOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBpbGx1bVtDSEFOTkVM
X1NDQU5fSU5ERVhfTUFYXTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTY0
IHRpbWVzdGFtcCBfX2FsaWduZWQoOCk7Cj4gPiBAQCAtMzMsOSArMzQsMTYgQEAgc3RydWN0IGFs
c19zdGF0ZSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IHNjYWxlX3Bvc3RfZGVjbWw7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgaW50IHNjYWxlX3ByZWNpc2lvbjsKPiA+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgdmFsdWVfb2Zmc2V0Owo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IG51bV9jaGFubmVsczsKPiA+
IMKgwqDCoMKgwqDCoMKgwqBzNjQgdGltZXN0YW1wOwo+ID4gwqB9Owo+ID4gwqAKPiA+ICsvKiBU
aGUgb3JkZXIgb2YgdXNhZ2UgaWRzIG11c3QgbWF0Y2ggc2NhbiBpbmRleCBzdGFydGluZyBmcm9t
Cj4gPiBDSEFOTkVMX1NDQU5fSU5ERVhfSU5URU5TSVRZICovCj4gPiArc3RhdGljIGNvbnN0IHUz
MiBhbHNfdXNhZ2VfaWRzW10gPSB7Cj4gPiArwqDCoMKgwqDCoMKgwqBISURfVVNBR0VfU0VOU09S
X0xJR0hUX0lMTFVNLAo+ID4gK8KgwqDCoMKgwqDCoMKgSElEX1VTQUdFX1NFTlNPUl9MSUdIVF9J
TExVTSwKPiA+ICt9Owo+ID4gKwo+ID4gwqBzdGF0aWMgY29uc3QgdTMyIGFsc19zZW5zaXRpdml0
eV9hZGRyZXNzZXNbXSA9IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBISURfVVNBR0VfU0VOU09SX0RB
VEFfTElHSFQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgSElEX1VTQUdFX1NFTlNPUl9MSUdIVF9JTExV
TSwKPiA+IEBAIC02OCw2ICs3Niw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBhbHNfY2hhbm5lbHNbXQo+ID4gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgSUlPX0NIQU5fU09G
VF9USU1FU1RBTVAoQ0hBTk5FTF9TQ0FOX0lOREVYX1RJTUVTVEFNUCkKPiA+IMKgfTsKPiA+IMKg
Cj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgYWxzX3NjYW5fbWFza1tdID0gezAsIDB9Owo+IAo+
IEdsb2JhbD8gTm8uIENvdWxkIGJlIG11bHRpcGxlIGluc3RhbmNlcyB3aXRoIGRpZmZlcmVudCBz
ZW5zb3JzCj4gc3VwcG9ydGVkLgo+IE5lZWRzIHRvIGJlIGVtYmVkZGVkIGluIHRoZSBhbHNfc3Rh
dGUgc3RydWN0dXJlIHNvIGl0IGlzIHBlcgo+IGluc3RhbmNlLgo+IAo+ID4gKwo+ID4gwqAvKiBB
ZGp1c3QgY2hhbm5lbCByZWFsIGJpdHMgYmFzZWQgb24gcmVwb3J0IGRlc2NyaXB0b3IgKi8KPiA+
IMKgc3RhdGljIHZvaWQgYWxzX2FkanVzdF9jaGFubmVsX2JpdF9tYXNrKHN0cnVjdCBpaW9fY2hh
bl9zcGVjCj4gPiAqY2hhbm5lbHMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBjaGFu
bmVsLCBpbnQgc2l6ZSkKPiA+IEBAIC0yMzgsMjcgKzI0OCwzOCBAQCBzdGF0aWMgaW50IGFsc19j
YXB0dXJlX3NhbXBsZShzdHJ1Y3QKPiA+IGhpZF9zZW5zb3JfaHViX2RldmljZSAqaHNkZXYsCj4g
PiDCoC8qIFBhcnNlIHJlcG9ydCB3aGljaCBpcyBzcGVjaWZpYyB0byBhbiB1c2FnZSBpZCovCj4g
PiDCoHN0YXRpYyBpbnQgYWxzX3BhcnNlX3JlcG9ydChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBoaWRfc2Vuc29yX2h1Yl9kZXZpY2UKPiA+ICpoc2RldiwK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFubmVscywKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCB1c2FnZV9pZCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWxzX3N0YXRlICpzdCkKPiA+IMKgewo+
ID4gLcKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBpaW9f
Y2hhbl9zcGVjICpjaGFubmVsczsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQsIGluZGV4ID0g
MDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgaTsKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqBm
b3IgKGkgPSAwOyBpIDw9IENIQU5ORUxfU0NBTl9JTkRFWF9JTExVTTsgKytpKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqBjaGFubmVscyA9IHN0LT5jaGFubmVsczsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoGZvciAoaSA9IDA7IGkgPCBDSEFOTkVMX1NDQU5fSU5ERVhfTUFYOyArK2kpIHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gc2Vuc29yX2h1Yl9pbnB1dF9nZXRf
YXR0cmlidXRlX2luZm8oaHNkZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBISURfSU5QVVRfUkVQT1JULAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdXNhZ2VfaWQsCj4gPiAtCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgSElEX1VTQUdFX1NFTlNPUl9MSUdICj4gPiBUX0lMTFVNLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbHNfdXNhZ2VfaWRzW2ldLAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJnN0LT5hbHNbaV0pOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbHNfYWRqdXN0X2NoYW5uZWxfYml0X21hc2soY2hh
bm5lbHMsIGksIHN0LQo+ID4gPmFsc1tpXS5zaXplKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hhbm5lbHNbaW5kZXhdID0gYWxzX2NoYW5uZWxzW2ldOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFsc19zY2FuX21hc2tbMF0gfD0gQklU
KGkpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFsc19hZGp1c3RfY2hhbm5l
bF9iaXRfbWFzayhjaGFubmVscywgaW5kZXgsIHN0LQo+ID4gPmFsc1tpXS5zaXplKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqArK2luZGV4Owo+ID4gwqAKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZygmcGRldi0+ZGV2LCAiYWxzICV4OiV4XG4i
LCBzdC0KPiA+ID5hbHNbaV0uaW5kZXgsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzdC0+YWxzW2ldLnJlcG9ydF9pZCk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgfQo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoHN0LT5udW1fY2hhbm5lbHMgPSBpbmRl
eDsKPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFJldHVybiBzdWNjZXNzIGV2ZW4gaWYgb25lIHVzYWdl
IGlkIGlzIHByZXNlbnQgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpbmRleCkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAwOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKg
wqDCoHN0LT5zY2FsZV9wcmVjaXNpb24gPSBoaWRfc2Vuc29yX2Zvcm1hdF9zY2FsZSh1c2FnZV9p
ZCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAmc3QtCj4gPiA+YWxzW0NIQU5ORUxfU0NBTl9JTkRFWF9JTlRFTlNJVFld
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCZzdC0+c2NhbGVfcHJlX2RlY21sLCAmc3QtCj4gPiA+c2NhbGVfcG9zdF9k
ZWNtbCk7Cj4gPiBAQCAtMjk0LDE1ICszMTUsNyBAQCBzdGF0aWMgaW50IGhpZF9hbHNfcHJvYmUo
c3RydWN0Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+
IC3CoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+Y2hhbm5lbHMgPSBkZXZtX2ttZW1kdXAoJnBkZXYt
PmRldiwKPiA+IGFsc19jaGFubmVscywKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNp
emVvZihhbHNfY2hhbm5lbHMpLAo+ID4gR0ZQX0tFUk5FTCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBp
ZiAoIWluZGlvX2Rldi0+Y2hhbm5lbHMpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZHVwbGljYXRlCj4gPiBjaGFubmVs
c1xuIik7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07
Cj4gPiAtwqDCoMKgwqDCoMKgwqB9Cj4gPiAtCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gYWxz
X3BhcnNlX3JlcG9ydChwZGV2LCBoc2RldiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAq
KWluZGlvX2Rldi0KPiA+ID5jaGFubmVscywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoc2Rldi0+dXNhZ2UsCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YWxzX3N0YXRlKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gPiBAQCAtMzEwLDgg
KzMyMywxNSBAQCBzdGF0aWMgaW50IGhpZF9hbHNfcHJvYmUoc3RydWN0Cj4gPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBy
ZXQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoGluZGlv
X2Rldi0+bnVtX2NoYW5uZWxzID0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFSUkFZX1NJWkUoYWxzX2NoYW5uZWxzKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoC8qIEFkZCB0aW1lc3RhbXAgY2hhbm5lbCAqLwo+ID4gK8KgwqDC
oMKgwqDCoMKgYWxzX3N0YXRlLT5jaGFubmVsc1thbHNfc3RhdGUtPm51bV9jaGFubmVsc10gPQo+
ID4gYWxzX2NoYW5uZWxzW0NIQU5ORUxfU0NBTl9JTkRFWF9USU1FU1RBTVBdOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgLyogKzEgZm9yIGFkZGluZyB0aW1lc3RhbXAgY2hhbm5lbCAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBhbHNfc3RhdGUtPm51bV9j
aGFubmVscyArIDE7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpbmRpb19kZXYtPmNoYW5uZWxz
ID0gYWxzX3N0YXRlLT5jaGFubmVsczsKPiA+ICvCoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+YXZh
aWxhYmxlX3NjYW5fbWFza3MgPSBhbHNfc2Nhbl9tYXNrOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKg
wqDCoGluZGlvX2Rldi0+aW5mbyA9ICZhbHNfaW5mbzsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpbmRp
b19kZXYtPm5hbWUgPSBuYW1lOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGluZGlvX2Rldi0+bW9kZXMg
PSBJTkRJT19ESVJFQ1RfTU9ERTsKPiAKCg==


