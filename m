Return-Path: <linux-iio+bounces-17034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62651A67AF1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECECF19C1508
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF84211A2E;
	Tue, 18 Mar 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="XeGVAgWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449F211A10
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318798; cv=none; b=AQEtbmPrw+NYtd/Ui1fFwhxIbU2ol2sd9gFU0u/Wo90Y8bVZao03d8JIflFiApwjMFT84KsOzatw9EwlyIhk9ATyphJEgNACzCgerH2Hotbq1VVnlsMoF5e6kpHM8z9SzuJYBIJ31Tdm6EWeENAeL/GykgJTWBnGPYOpmmzMMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318798; c=relaxed/simple;
	bh=jlyVgQ3QLZKfAj+By39Kc3zFGFFb1NyxKeclUYrfuss=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=eq14owdJoNRc4kYgeQqNvqNgzYCXWrXurCEme3+4U0ZBdybKGtDpllSgESosQiJX9Ca1CuT67qFv3sSMTieNWgJgKQOo1XCaetHB4Y4qviql2RVxuvh/71zgmlMZaHEXmvdKrJaR3nw+UU+qWrQXfovbhgFzXRSflOJ0Yu0G4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=XeGVAgWQ; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=UboAMlMhQ+H2NLTkbY/5uvVF6uX1L8blj+6IJ+FPIQE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From:x-icloud-hme;
	b=XeGVAgWQflnwKfBcXgg5X8h1zpiDwDxkv8TzpNGVTnnJonwjmQwVzzhpozxrZqY6a
	 etoMczsB1l/Wlpj8e93pQdCv3MMGM0b97Hef8xOva9iJzut4pJXJOnZjg7EENp8q7S
	 Ra/flEvETYi4R6jr0XLY1177BUietccbhiTVfXmqBu6Cyv4ta0zoKwQWHhaR/S9Hb3
	 OQL9GNWoUQ9wTtPI65Bl3kB9MqCHvsaKyxegxWu/QNg0x3EYEL7+aL6L3oEobC8LYZ
	 f6OLkQtDRRnGumhmGpnfwqSJZIBuTHt+jb37f23U7OuNY6QJ/DtqH411OobbtGABPH
	 iH8BavETr5yCA==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id E93ED4E404E2;
	Tue, 18 Mar 2025 17:26:30 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------JepsJeDPf5CnPaoPN0Bw4Onc"
Message-ID: <bf16371c-189c-4e51-91e5-129f1dcad317@pereznus.es>
Date: Tue, 18 Mar 2025 18:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org
Cc: tduszyns@gmail.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
 <f0536d74-5433-4086-9dfc-1ce6aeeebe00@pereznus.es>
 <8992a79d-0859-4d7f-9b47-52e20b11260a@kernel.org>
 <144b5c43-f8c6-44d1-bcff-83158ac29781@pereznus.es>
 <202b4446-0ce4-4288-8588-6edfc32125d1@kernel.org>
 <bde38364-5c20-4030-ad7d-9ae38971b260@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <bde38364-5c20-4030-ad7d-9ae38971b260@kernel.org>
X-Proofpoint-GUID: QpS1lxewqjhXu5vPtNHLJUsKHRGpDBlp
X-Proofpoint-ORIG-GUID: QpS1lxewqjhXu5vPtNHLJUsKHRGpDBlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1030 spamscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503180127

This is a multi-part message in MIME format.
--------------JepsJeDPf5CnPaoPN0Bw4Onc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


El 18/03/2025 a las 17:23, Krzysztof Kozlowski escribió:
> On 18/03/2025 17:21, Krzysztof Kozlowski wrote:
>> On 18/03/2025 17:06, Sergio Pérez wrote:
>>> El 18/03/2025 a las 16:16, Krzysztof Kozlowski escribió:
>>>> On 18/03/2025 15:16, Sergio Pérez wrote:
>>>>> Hello,
>>>>>
>>>>> El 17/03/2025 a las 8:24, Krzysztof Kozlowski escribió:
>>>>>> On 16/03/2025 15:55, Sergio Perez wrote:
>>>>>>> Some BH1750 sensors require a hardware reset before they can be
>>>>>>> detected on the I2C bus. This patch adds support for an optional
>>>>>>> reset GPIO that can be specified in the device tree.
>>>>>>>
>>>>>>> The reset sequence pulls the GPIO low and then high before
>>>>>>> initializing the sensor, which enables proper detection with
>>>>>>> tools like i2cdetect.
>>>>>>>
>>>>>>> Update the devicetree binding documentation to include the new
>>>>>>> reset-gpios property with examples.
>>>>>>>
>>>>>>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>>>>>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>>>>>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>>>>>> warnings. Some warnings can be ignored, especially from --strict run,
>>>>>> but the code here looks like it needs a fix. Feel free to get in touch
>>>>>> if the warning is not clear.
>>>> You keep ignoring paragraphs. Did you read this?
>>> I pass this check several times and every time I do any step to make
>>> sure I am well.
>>>
>>> scripts/checkpatch.pl -f drivers/iio/light/bh1750.c
>>> total: 0 errors, 0 warnings, 354 lines checked
>>
>> That's not how you run checkpatch. Read the submitting patches. Just
>> like the name tells you, check the patch, you run it on the patch.
> BTW, I wonder which guideline told you to run it on the file? Because
> checkpatch description and submitting patches tell about running it on
> the patches, so I wonder where did you get suggestion to run it like that?
You're absolutely right. I misunderstood how to use checkpatch.pl and 
was incorrectly running it on the source files instead of the patch 
file. Thank you for pointing this out.

$ scripts/checkpatch.pl --strict -f 
0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch
total: 0 errors, 0 warnings, 0 checks, 102 lines checked

0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch has no 
obvious style problems and is ready for submission.

I've now run the tool correctly on my patch file and have fixed the 
identified issues:
- Removed trailing whitespace
- Fixed lines exceeding 79 characters
- Fixed the inconsistency between the description and example for 
reset-gpios
- Modified the existing example instead of adding a new one
- Ensured proper line endings and formatting
- Used proper get_maintainers.pl to include all recipients

Thank you for your patience as I learn the proper kernel contribution 
process.
>
> Best regards,
> Krzysztof
--------------JepsJeDPf5CnPaoPN0Bw4Onc
Content-Type: text/plain; charset=UTF-8;
 name="0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch"
Content-Disposition: attachment;
 filename*0="0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwYjBmOGYwZjc5ODhlY2NiNmI0ZWQ0Mjk4NGM1YmRlMDkyYjFkNWZlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gUGVyZXogPHNlcmdpb0BwZXJlem51cy5l
cz4KRGF0ZTogVHVlLCAxOCBNYXIgMjAyNSAwMToxMjowNSArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGlpbzogbGlnaHQ6IGJoMTc1MDogQWRkIGhhcmR3YXJlIHJlc2V0IHN1cHBvcnQgdmlh
IEdQSU8KClNvbWUgQkgxNzUwIHNlbnNvcnMgcmVxdWlyZSBhIGhhcmR3YXJlIHJlc2V0IGJl
Zm9yZSB0aGV5IGNhbiBiZQpkZXRlY3RlZCBvbiB0aGUgSTJDIGJ1cy4gVGhpcyBwYXRjaCBh
ZGRzIHN1cHBvcnQgZm9yIGFuIG9wdGlvbmFsCnJlc2V0IEdQSU8gdGhhdCBjYW4gYmUgc3Bl
Y2lmaWVkIGluIHRoZSBkZXZpY2UgdHJlZS4KClRoZSByZXNldCBzZXF1ZW5jZSBwdWxscyB0
aGUgR1BJTyBsb3cgYW5kIHRoZW4gaGlnaCBiZWZvcmUKaW5pdGlhbGl6aW5nIHRoZSBzZW5z
b3IsIHdoaWNoIGVuYWJsZXMgcHJvcGVyIGRldGVjdGlvbiB3aXRoCnRvb2xzIGxpa2UgaTJj
ZGV0ZWN0LgoKVXBkYXRlIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB0
byBpbmNsdWRlIHRoZSBuZXcKcmVzZXQtZ3Bpb3MgcHJvcGVydHkgd2l0aCBleGFtcGxlcy4K
ClNpZ25lZC1vZmYtYnk6IFNlcmdpbyBQZXJleiA8c2VyZ2lvQHBlcmV6bnVzLmVzPgotLS0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdodC9iaDE3NTAueWFtbCB8ICA1ICsr
KysKIGRyaXZlcnMvaWlvL2xpZ2h0L2JoMTc1MC5jICAgICAgICAgICAgICAgICAgICB8IDIz
ICsrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
bGlnaHQvYmgxNzUwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2xpZ2h0L2JoMTc1MC55YW1sCmluZGV4IDFhODhiM2MyNTNkNS4uZjdhOGRjZDdkMmEx
IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2xp
Z2h0L2JoMTc1MC55YW1sCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vbGlnaHQvYmgxNzUwLnlhbWwKQEAgLTI0LDYgKzI0LDEwIEBAIHByb3BlcnRpZXM6
CiAgIHJlZzoKICAgICBtYXhJdGVtczogMQoKKyAgcmVzZXQtZ3Bpb3M6CisgICAgZGVzY3Jp
cHRpb246IEdQSU8gY29ubmVjdGVkIHRvIHRoZSBzZW5zb3IncyByZXNldCBsaW5lIChhY3Rp
dmUgbG93KQorICAgIG1heEl0ZW1zOiAxCisKIHJlcXVpcmVkOgogICAtIGNvbXBhdGlibGUK
ICAgLSByZWcKQEAgLTM5LDYgKzQzLDcgQEAgZXhhbXBsZXM6CiAgICAgICBsaWdodC1zZW5z
b3JAMjMgewogICAgICAgICBjb21wYXRpYmxlID0gInJvaG0sYmgxNzUwIjsKICAgICAgICAg
cmVnID0gPDB4MjM+OworICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzIgMTcgMD47CiAg
ICAgICB9OwogICAgIH07CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvYmgxNzUw
LmMgYi9kcml2ZXJzL2lpby9saWdodC9iaDE3NTAuYwppbmRleCA0Yjg2OWZhOWU1YjEuLmNm
Y2NlMGM3M2FhMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vbGlnaHQvYmgxNzUwLmMKKysr
IGIvZHJpdmVycy9paW8vbGlnaHQvYmgxNzUwLmMKQEAgLTIyLDEyICsyMiwxNiBAQAogI2lu
Y2x1ZGUgPGxpbnV4L2lpby9paW8uaD4KICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1
bWVyLmg+CgogI2RlZmluZSBCSDE3NTBfUE9XRVJfRE9XTgkJMHgwMAogI2RlZmluZSBCSDE3
NTBfT05FX1RJTUVfSF9SRVNfTU9ERQkweDIwIC8qIGF1dG8tbW9kZSBmb3IgQkgxNzIxICov
CiAjZGVmaW5lIEJIMTc1MF9DSEFOR0VfSU5UX1RJTUVfSF9CSVQJMHg0MAogI2RlZmluZSBC
SDE3NTBfQ0hBTkdFX0lOVF9USU1FX0xfQklUCTB4NjAKCisvKiBEZWZpbmUgdGhlIHJlc2V0
IGRlbGF5IHRpbWUgaW4gbWljcm9zZWNvbmRzICovCisjZGVmaW5lIEJIMTc1MF9SRVNFVF9E
RUxBWV9VUyAxMDAwMCAvKiAxMG1zICovCisKIGVudW0gewogCUJIMTcxMCwKIAlCSDE3MjEs
CkBAIC00MCw2ICs0NCw3IEBAIHN0cnVjdCBiaDE3NTBfZGF0YSB7CiAJc3RydWN0IG11dGV4
IGxvY2s7CiAJY29uc3Qgc3RydWN0IGJoMTc1MF9jaGlwX2luZm8gKmNoaXBfaW5mbzsKIAl1
MTYgbXRyZWc7CisJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsKIH07Cgogc3RydWN0
IGJoMTc1MF9jaGlwX2luZm8gewpAQCAtMjQ4LDYgKzI1MywyNCBAQCBzdGF0aWMgaW50IGJo
MTc1MF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogCWRhdGEtPmNsaWVudCA9
IGNsaWVudDsKIAlkYXRhLT5jaGlwX2luZm8gPSAmYmgxNzUwX2NoaXBfaW5mb190YmxbaWQt
PmRyaXZlcl9kYXRhXTsKCisJLyogR2V0IHJlc2V0IEdQSU8gZnJvbSBkZXZpY2UgdHJlZSAq
LworCWRhdGEtPnJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmY2xpZW50
LT5kZXYsCisJCQkJInJlc2V0IiwgR1BJT0RfT1VUX0hJR0gpOworCWlmIChJU19FUlIoZGF0
YS0+cmVzZXRfZ3BpbykpCisJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZjbGllbnQtPmRldiwg
UFRSX0VSUihkYXRhLT5yZXNldF9ncGlvKSwKKwkJCQkiRmFpbGVkIHRvIGdldCByZXNldCBH
UElPXG4iKTsKKworCS8qIFBlcmZvcm0gaGFyZHdhcmUgcmVzZXQgaWYgR1BJTyBpcyBwcm92
aWRlZCAqLworCWlmIChkYXRhLT5yZXNldF9ncGlvKSB7CisJCS8qIFBlcmZvcm0gcmVzZXQg
c2VxdWVuY2U6IGxvdy1oaWdoICovCisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChkYXRh
LT5yZXNldF9ncGlvLCAwKTsKKwkJZnNsZWVwKEJIMTc1MF9SRVNFVF9ERUxBWV9VUyk7CisJ
CWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChkYXRhLT5yZXNldF9ncGlvLCAxKTsKKwkJZnNs
ZWVwKEJIMTc1MF9SRVNFVF9ERUxBWV9VUyk7CisKKwkJZGV2X2RiZygmY2xpZW50LT5kZXYs
ICJCSDE3NTAgcmVzZXQgY29tcGxldGVkIHZpYSBHUElPXG4iKTsKKwl9CisKIAl1c2VjID0g
ZGF0YS0+Y2hpcF9pbmZvLT5tdHJlZ190b191c2VjICogZGF0YS0+Y2hpcF9pbmZvLT5tdHJl
Z19kZWZhdWx0OwogCXJldCA9IGJoMTc1MF9jaGFuZ2VfaW50X3RpbWUoZGF0YSwgdXNlYyk7
CiAJaWYgKHJldCA8IDApCi0tCjIuNDMuMAoK

--------------JepsJeDPf5CnPaoPN0Bw4Onc--

