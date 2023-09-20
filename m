Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549D7A89EC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjITRBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITRBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 13:01:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84099;
        Wed, 20 Sep 2023 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695229286; x=1726765286;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=ChhV9WO72VeFgZCrgVMxj+u9x8z0JTOTdD/3VKqXsc0=;
  b=SSa3fUnjKQG66WyulSYRvu03gw3UMTNDsgyFiOpiDncsGwkruWPt6k8y
   OnUMfRwnXD7wdPPyCErfa2cUn3FWQn2KNOfUlQsLxL4jx0MYOJ5iAX05A
   sbWlu2AOWj1grekzngJhteVsYo+8gR+C5jCGyjTMB/jV6TnA3vL1uxTog
   m5Kv7x9CwD+IYatoNyBhW5XYJT1EatCIsOMW3wpjz/DTS3xkeWK9HEI84
   Uo0q8pcF2TgQMMGzHKtio+zTJZ0YwySo0Uv4f505oRdMsNCdAvMICdzU/
   la1tRlLu7qYOp62fj4OEc8hTy1sg+YULJHAGisWqPX7vnU5qIOjz9NkOU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466592317"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="466592317"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="816978260"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="816978260"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.142.24])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:00:52 -0700
Message-ID: <f708fb6479ed75f4a326b471478eae79fdfba317.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/9] iio: hid-sensor-als: Add light color temperature
 support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Wed, 20 Sep 2023 10:00:52 -0700
In-Reply-To: <20230919081054.2050714-4-Basavaraj.Natikar@amd.com>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
         <20230919081054.2050714-4-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTE5IGF0IDEzOjQwICswNTMwLCBCYXNhdmFyYWogTmF0aWthciB3cm90
ZToKPiBJbiBtb3N0IGNhc2VzLCBhbWJpZW50IGNvbG9yIHNlbnNvcnMgYWxzbyBzdXBwb3J0IGxp
Z2h0IGNvbG9yCj4gdGVtcGVyYXR1cmUuCj4gQXMgYSByZXN1bHQsIGFkZCBzdXBwb3J0IG9mIGxp
Z2h0IGNvbG9yIHRlbXBlcmF0dXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJhc2F2YXJhaiBOYXRp
a2FyIDxCYXNhdmFyYWouTmF0aWthckBhbWQuY29tPgpBY2tlZC1ieTogU3Jpbml2YXMgUGFuZHJ1
dmFkYTxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KCj4gLS0tCj4gwqBkcml2
ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLWFscy5jIHwgMzcKPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0KPiDCoGluY2x1ZGUvbGludXgvaGlkLXNlbnNvci1pZHMuaMKgwqDCoMKgIHzC
oCAxICsKPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1hbHMuYwo+
IGIvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1hbHMuYwo+IGluZGV4IGVmYjFmODg2MmIy
OC4uMTZhM2YxOTQxYzI3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2hpZC1zZW5z
b3ItYWxzLmMKPiArKysgYi9kcml2ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLWFscy5jCj4gQEAg
LTE0LDggKzE0LDkgQEAKPiDCoCNpbmNsdWRlICIuLi9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNl
bnNvci10cmlnZ2VyLmgiCj4gwqAKPiDCoGVudW0gewo+IC3CoMKgwqDCoMKgwqDCoENIQU5ORUxf
U0NBTl9JTkRFWF9JTlRFTlNJVFkgPSAwLAo+IC3CoMKgwqDCoMKgwqDCoENIQU5ORUxfU0NBTl9J
TkRFWF9JTExVTSA9IDEsCj4gK8KgwqDCoMKgwqDCoMKgQ0hBTk5FTF9TQ0FOX0lOREVYX0lOVEVO
U0lUWSwKPiArwqDCoMKgwqDCoMKgwqBDSEFOTkVMX1NDQU5fSU5ERVhfSUxMVU0sCj4gK8KgwqDC
oMKgwqDCoMKgQ0hBTk5FTF9TQ0FOX0lOREVYX0NPTE9SX1RFTVAsCj4gwqDCoMKgwqDCoMKgwqDC
oENIQU5ORUxfU0NBTl9JTkRFWF9NQVgKPiDCoH07Cj4gwqAKPiBAQCAtNjUsNiArNjYsMTYgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGFsc19jaGFubmVsc1tdID0KPiB7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBCSVQoSUlPX0NIQU5fSU5GT19IWVNURVJF
U0lTX1JFTEFUSVZFKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zY2FuX2lu
ZGV4ID0gQ0hBTk5FTF9TQ0FOX0lOREVYX0lMTFVNLAo+IMKgwqDCoMKgwqDCoMKgwqB9LAo+ICvC
oMKgwqDCoMKgwqDCoHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnR5cGUgPSBJ
SU9fQ09MT1JURU1QLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW5mb19tYXNr
X3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLmluZm9fbWFza19zaGFyZWRfYnlfdHlwZSA9IEJJVChJSU9fQ0hBTl9JTkZP
X09GRlNFVCkKPiB8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJVChJSU9fQ0hB
Tl9JTkZPX1NDQUxFKSB8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJVChJSU9f
Q0hBTl9JTkZPX1NBTVBfRlJFUSkgfAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBC
SVQoSUlPX0NIQU5fSU5GT19IWVNURVJFU0lTKSB8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoEJJVChJSU9fQ0hBTl9JTkZPX0hZU1RFUkVTSVNfUkVMQVRJVkUpLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2Nhbl9pbmRleCA9IENIQU5ORUxfU0NBTl9JTkRFWF9D
T0xPUl9URU1QLAo+ICvCoMKgwqDCoMKgwqDCoH0sCj4gwqDCoMKgwqDCoMKgwqDCoElJT19DSEFO
X1NPRlRfVElNRVNUQU1QKENIQU5ORUxfU0NBTl9JTkRFWF9USU1FU1RBTVApCj4gwqB9Owo+IMKg
Cj4gQEAgLTEwMyw2ICsxMTQsMTEgQEAgc3RhdGljIGludCBhbHNfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYKPiAqaW5kaW9fZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoG1pbiA9IGFsc19zdGF0ZS0+YWxzW2NoYW4tCj4gPnNjYW5faW5kZXhdLmxv
Z2ljYWxfbWluaW11bTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBhZGRyZXNzID0gSElEX1VTQUdFX1NFTlNPUl9MSUdIVF9JTExVTTsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZcKgIENIQU5ORUxfU0NBTl9JTkRFWF9DT0xPUl9U
RU1QOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVw
b3J0X2lkID0gYWxzX3N0YXRlLT5hbHNbY2hhbi0KPiA+c2Nhbl9pbmRleF0ucmVwb3J0X2lkOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWluID0gYWxz
X3N0YXRlLT5hbHNbY2hhbi0KPiA+c2Nhbl9pbmRleF0ubG9naWNhbF9taW5pbXVtOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRkcmVzcyA9Cj4gSElE
X1VTQUdFX1NFTlNPUl9MSUdIVF9DT0xPUl9URU1QRVJBVFVSRTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXBvcnRfaWQgPSAtMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiBAQCAtMjIzLDYgKzIzOSwxMCBAQCBz
dGF0aWMgaW50IGFsc19jYXB0dXJlX3NhbXBsZShzdHJ1Y3QKPiBoaWRfc2Vuc29yX2h1Yl9kZXZp
Y2UgKmhzZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWxzX3N0YXRlLT5z
Y2FuLmlsbHVtW0NIQU5ORUxfU0NBTl9JTkRFWF9JTExVTV0gPQo+IHNhbXBsZV9kYXRhOwo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gMDsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgSElEX1VTQUdFX1NF
TlNPUl9MSUdIVF9DT0xPUl9URU1QRVJBVFVSRToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgYWxzX3N0YXRlLT5zY2FuLmlsbHVtW0NIQU5ORUxfU0NBTl9JTkRFWF9DT0xPUl9URU1Q
XQo+ID0gc2FtcGxlX2RhdGE7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9
IDA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDC
oMKgwqBjYXNlIEhJRF9VU0FHRV9TRU5TT1JfVElNRV9USU1FU1RBTVA6Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhbHNfc3RhdGUtPnRpbWVzdGFtcCA9Cj4gaGlkX3NlbnNvcl9j
b252ZXJ0X3RpbWVzdGFtcCgmYWxzX3N0YXRlLT5jb21tb25fYXR0cmlidXRlcywKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoAo+ICooczY0ICopcmF3X2RhdGEpOwo+IEBAIC0yNTgsNiArMjc4LDE5IEBA
IHN0YXRpYyBpbnQgYWxzX3BhcnNlX3JlcG9ydChzdHJ1Y3QKPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Qt
PmFsc1tpXS5yZXBvcnRfaWQpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDC
oMKgwqByZXQgPSBzZW5zb3JfaHViX2lucHV0X2dldF9hdHRyaWJ1dGVfaW5mbyhoc2RldiwKPiBI
SURfSU5QVVRfUkVQT1JULAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVzYWdlX2lkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEhJRF9VU0FHRV9TRU5T
T1JfTElHSFRfQ09MT1JfVEVNUEVSQVQKPiBVUkUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJnN0LQo+ID5hbHNbQ0hBTk5F
TF9TQ0FOX0lOREVYX0NPTE9SX1RFTVBdKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDC
oMKgwqBhbHNfYWRqdXN0X2NoYW5uZWxfYml0X21hc2soY2hhbm5lbHMsCj4gQ0hBTk5FTF9TQ0FO
X0lOREVYX0NPTE9SX1RFTVAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtCj4gPmFsc1tDSEFOTkVMX1NDQU5fSU5ERVhf
Q09MT1JfVEVNUF0uc2l6ZSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGRldl9kYmcoJnBkZXYtPmRl
diwgImFscyAleDoleFxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtPmFs
c1tDSEFOTkVMX1NDQU5fSU5ERVhfQ09MT1JfVEVNUF0uaW5kZXgsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN0LT5hbHNbQ0hBTk5FTF9TQ0FOX0lOREVYX0NPTE9SX1RFTVBdLnJl
cG9ydF9pZCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBzdC0+c2NhbGVfcHJlY2lzaW9uID0gaGlk
X3NlbnNvcl9mb3JtYXRfc2NhbGUodXNhZ2VfaWQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZzdC0KPiA+YWxzW0NIQU5O
RUxfU0NBTl9JTkRFWF9JTlRFTlNJVFldLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAmc3QtPnNjYWxlX3ByZV9kZWNtbCwg
JnN0LQo+ID5zY2FsZV9wb3N0X2RlY21sKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9o
aWQtc2Vuc29yLWlkcy5oIGIvaW5jbHVkZS9saW51eC9oaWQtCj4gc2Vuc29yLWlkcy5oCj4gaW5k
ZXggMTNiMWU2NWZiZGNjLi44YWY0ZmIzZTAyNTQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC9oaWQtc2Vuc29yLWlkcy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9oaWQtc2Vuc29yLWlkcy5o
Cj4gQEAgLTIxLDYgKzIxLDcgQEAKPiDCoCNkZWZpbmUKPiBISURfVVNBR0VfU0VOU09SX0FMU8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAweDIwMDA0MQo+IMKgI2RlZmluZQo+IEhJRF9VU0FHRV9TRU5TT1JfREFUQV9M
SUdIVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgMHgyMDA0ZDAKPiDCoCNkZWZpbmUKPiBISURfVVNBR0VfU0VOU09SX0xJR0hUX0lMTFVNwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgyMDA0
ZDEKPiArI2RlZmluZQo+IEhJRF9VU0FHRV9TRU5TT1JfTElHSFRfQ09MT1JfVEVNUEVSQVRVUkXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDIwMDRkMgo+IMKgCj4gwqAvKiBQUk9YICgy
MDAwMTEpICovCj4gwqAjZGVmaW5lIEhJRF9VU0FHRV9TRU5TT1JfUFJPWMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4g
MHgyMDAwMTEKCg==

