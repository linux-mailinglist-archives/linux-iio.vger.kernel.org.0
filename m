Return-Path: <linux-iio+bounces-22539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD1B1FC4D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 23:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A447A281B
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570C279DDA;
	Sun, 10 Aug 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B612X3VZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DAE279DB7
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860348; cv=none; b=sWqW68WWblEUmsxeJXEwPhywr4g0wgjTC8xIu+jLeq+vOwndIbtRA3hQVXRFyUw07hkneScDEn4gsqJUZ5ltxksAFT+Owsv2C2Bv3B6bMdq5osg2tL5miXXQBFPZ19AOm5BHYErKBDjjrvrvRUOHPj6tf5+y8ivEiOQrMCqFaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860348; c=relaxed/simple;
	bh=l+LS9ddrNXP6h3vQu3PLw8ul7esjrhdgJVupv3D4fC4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=rQDjR/HhS7DVBqKVapKbSSsKr/qoPjn5HTLteiUfMIOfPo6ILDNsrfAYeTOuKb+CTjAnVIXeJyQuM2nh6byiNn5xjry4FMJidbuYnaKj/qqwJcVO5+89o3JQzaDAbM87qMjXJw/AKWlRW65YqhR2uwN1RO3s+9Rs7ZkNqb38hY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B612X3VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762BEC4CEF7;
	Sun, 10 Aug 2025 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860347;
	bh=l+LS9ddrNXP6h3vQu3PLw8ul7esjrhdgJVupv3D4fC4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B612X3VZQuPJ6hsm1aZ3wqN+2W6rS+kILbO466xGNmFSChaJyWRYPvEmrQlIKg5eF
	 UOQ12ZLiS6FcZB4j7VLz1mxeKFtL3ztI4j4zA5o5UbR1huim1HZA+XchNkyg8f1g+k
	 62w9MASd4COxGybR2fJquZm87q0uZpk5B0jmIQPWjq8R+KIG/TssktriVd5m0kwllg
	 0y+NC/dFc69+PQi3sMnhQI+MflN3OKnJ5oSo0dzdrnREuU7VwA3NP7ZkAZxhSIMJgT
	 47n91eNjf1AAkfUQuU0veNX/c20u5kDZgyNSGSL8FcB0SLwLq+JiRpABjB+X7cLBsk
	 DMk/9CVYCSB+g==
Content-Type: multipart/mixed; boundary="------------OmK4ERs5QK0ZGRVzyGsojGAh"
Message-ID: <7810b341-1216-4fe4-8c05-17acb00430c7@kernel.org>
Date: Sun, 10 Aug 2025 23:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
From: Hans de Goede <hansg@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-2-hansg@kernel.org>
 <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
 <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>

This is a multi-part message in MIME format.
--------------OmK4ERs5QK0ZGRVzyGsojGAh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Aug-25 9:25 PM, Hans de Goede wrote:
> Hi David,
> 
> On 29-Jul-25 7:26 PM, David Lechner wrote:
>> On 7/27/25 4:06 PM, Hans de Goede wrote:
>>> Before this change iio_read_channel_processed_scale() always assumes that
>>> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
>>> IIO_VAL_INT on success.
>>>
>>> Ignoring any fractional values from drivers which return
>>> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
>>> might become non fractional after scaling so these should be taken into
>>> account.
>>>
>>> While at it also error out for IIO_VAL_* values which
>>> iio_read_channel_processed_scale() does not know how to handle.
>>>
>>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>>> ---
>>> Changes in v3:
>>> - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
>>> - Directly return IIO_VAL_INT from valid cases and drop the final
>>>   return ret after the switch-case
>>>
>>> Changes in v2:
>>> - New patch in v2 of this patch-series
>>> ---
>>>  drivers/iio/inkern.c | 24 ++++++++++++++++++++----
>>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>> index c174ebb7d5e6..46900be16ff8 100644
>>> --- a/drivers/iio/inkern.c
>>> +++ b/drivers/iio/inkern.c
>>> @@ -714,20 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>>>  				     unsigned int scale)
>>>  {
>>>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>>> -	int ret;
>>> +	int ret, val2;
>>>  
>>>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>>>  	if (!chan->indio_dev->info)
>>>  		return -ENODEV;
>>>  
>>>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>>> -		ret = iio_channel_read(chan, val, NULL,
>>> +		ret = iio_channel_read(chan, val, &val2,
>>>  				       IIO_CHAN_INFO_PROCESSED);
>>>  		if (ret < 0)
>>>  			return ret;
>>> -		*val *= scale;
>>>  
>>> -		return ret;
>>> +		switch (ret) {
>>> +		case IIO_VAL_INT:
>>> +			*val *= scale;
>>> +			return IIO_VAL_INT;
>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>> +			*val *= scale;
>>> +			*val += div_s64((s64)val2 * scale, 1000000LL);
>>> +			return IIO_VAL_INT;
>>> +		case IIO_VAL_INT_PLUS_NANO:
>>> +			*val *= scale;
>>> +			*val += div_s64((s64)val2 * scale, 1000000000LL);
>>> +			return IIO_VAL_INT;
>>
>> I would feel better if we had some kunit tests on this function since
>> the negative values can be tricky. I.e. something similar to
>> iio_test_iio_format_value_fixedpoint() that tests the 4 possible
>> interesting cases for val and val2.
>>
>> I think that would find a bug here. For example, if the processed
>> value is -1.5 with IIO_VAL_INT_PLUS_MICRO, then *val would be
>> -1 and *val2 would be 500_000 (before applying scale). And suppose
>> scale is 2. The expected result would be -1.5 * 2 = -3. But the math
>> here is:
>>
>> -1 * 2 + 500_000 * 2 / 1_000_000 = -1 != -3
> 
> Ack, after looking at iio_format_value and the kunit test for this
> I believe I know how this is supposed to work now.
> 
> Note that it seems that iio_convert_raw_to_processed_unlocked()
> also seems to get this wrong when the channel scale attribute
> is smaller then -1, e.g. your -1.5. Actually it seems that
> the code in iio_convert_raw_to_processed_unlocked() is making
> the exact same mistake you are highlighting in my code :)
> 
> I'll prepare a patch series to try and deal with this.

Ok, attached is a teaser of the patch-series I'm working on.

The first 2 patches fix 2 bugs in iio_convert_raw_to_processed()
which I noticed while working on this.

The third patch factors multiplication of a type, val,
val2 integer triplet by some integer number and storing
the result in an integer out into a new iio_mutiply_value()
helper. For re-use and so that a kunit-test can be written.

Patch 4 is a new version of the patch improving
iio_read_channel_processed_scale() precision using this helper.

What is missing for posting a new version is a kunit test
for the new helper. I hope to be able to work on that
tomorrow.

Regards,

Hans



--------------OmK4ERs5QK0ZGRVzyGsojGAh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-iio-consumers-Fix-handling-of-negative-channel-scale.patch"
Content-Disposition: attachment;
 filename*0="0001-iio-consumers-Fix-handling-of-negative-channel-scale.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4NDE3OTdiYzkwZTMyZjM2NmExZWU0ZWFhNWYzYTI2NzQ3NTQ2ZjdjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDEwIEF1ZyAyMDI1IDIxOjQ5OjM1ICswMjAwClN1YmplY3Q6IFtQQVRD
SCAxLzRdIGlpbzogY29uc3VtZXJzOiBGaXggaGFuZGxpbmcgb2YgbmVnYXRpdmUgY2hhbm5l
bCBzY2FsZSBpbgogaWlvX2NvbnZlcnRfcmF3X3RvX3Byb2Nlc3NlZCgpCgpUaGVyZSBpcyBh
biBpc3N1ZSB3aXRoIHRoZSBoYW5kbGluZyBvZiBuZWdhdGl2ZSBjaGFubmVsIHNjYWxlcwpp
biBpaW9fY29udmVydF9yYXdfdG9fcHJvY2Vzc2VkX3VubG9ja2VkKCkgd2hlbiB0aGUgY2hh
bm5lbC1zY2FsZQppcyBvZiB0aGUgSUlPX1ZBTF9JTlRfUExVU19bTUlDUk98TkFOT10gdHlw
ZToKClRoaW5ncyB3b3JrIGZvciBjaGFubmVsLXNjYWxlIHZhbHVlcyA+IC0xLjAgYW5kIDwg
MC4wIGJlY2F1c2Ugb2YKdGhlIHVzZSBvZiBzaWduZWQgdmFsdWVzIGluOgoKCSpwcm9jZXNz
ZWQgKz0gZGl2X3M2NChyYXc2NCAqIChzNjQpc2NhbGVfdmFsMiAqIHNjYWxlLCAxMDAwMDAw
TEwpOwoKVGhpbmdzIHdpbGwgYnJlYWsgaG93ZXZlciBmb3Igc2NhbGUgdmFsdWVzIDwgLTEu
MC4gTGV0cyBmb3IgZXhhbXBsZSBzYXkKdGhhdCByYXcgPSAyLCAoY2FsbGVyLXByb3ZpZGVk
KXNjYWxlID0gMTAgYW5kIChjaGFubmVsKXNjYWxlX3ZhbCA9IC0xLjUuCgpUaGUgcmVzdWx0
IHNob3VsZCB0aGVuIGJlIDIgKiAxMCAqIC0xLjUgPSAtMzAuCgpjaGFubmVsLXNjYWxlID0g
LTEuNSBtZWFucyBzY2FsZV92YWwgPSAtMSBhbmQgc2NhbGVfdmFsMiA9IDUwMDAwMCwKbm93
IGxldHMgc2VlIHdoYXQgZ2V0cyBzdG9yZWQgaW4gcHJvY2Vzc2VkOgoKMS4gKnByb2Nlc3Nl
ZCA9IHJhdzY0ICogc2NhbGVfdmFsICogc2NhbGU7CjIuICpwcm9jZXNzZWQgKz0gcmF3NjQg
KiBzY2FsZV92YWwyICogc2NhbGUgLyAxMDAwMDAwTEw7CgoxLiBTZXRzIHByb2Nlc3NlZCB0
byAyICogLTEgKiAxMCA9IC0yMAoyLiBBZGRzIDIgKiA1MDAwMDAgKiAxMCAvIDEwMDAwMDAg
PSAxMCB0byBwcm9jZXNzZWQKCkFuZCB0aGUgZW5kIHJlc3VsdCBpcyBwcm9jZXNzZWQgPSAt
MjAgKyAxMCA9IC0xMCwgd2hpY2ggaXMgbm90IGNvcnJlY3QuCgpGaXggdGhpcyBieSBhbHdh
eXMgdXNpbmcgdGhlIGFicyB2YWx1ZSBvZiBib3RoIHNjYWxlX3ZhbCBhbmQgc2NhbGVfdmFs
MgphbmQgaWYgZWl0aGVyIGlzIG5lZ2F0aXZlIG11bHRpcGx5IHRoZSBlbmQtcmVzdWx0IGJ5
IC0xLgoKTm90ZSB0aGVyZSBzZWVtcyB0byBiZSBhbiB1bndyaXR0ZW4gcnVsZSBhYm91dCBu
ZWdhdGl2ZQpJSU9fVkFMX0lOVF9QTFVTX1tNSUNST3xOQU5PXSB2YWx1ZXMgdGhhdDoKCmku
ICAgdmFsdWVzID4gLTEuMCBhbmQgPCAwLjAgYXJlIHdyaXR0ZW4gYXMgdmFsPTAgdmFsMj0t
eHh4CmlpLiAgdmFsdWVzIDw9IC0xLjAgYXJlIHdyaXR0ZW4gYXMgdmFsPS14eHggdmFsMj14
eHgKCkJ1dCBpaW9fZm9ybWF0X3ZhbHVlKCkgd2lsbCBhbHNvIGNvcnJlY3RseSBkaXNwbGF5
IGEgdGhpcmQgb3B0aW9uOgoKaWlpLiB2YWx1ZXMgPD0gLTEuMCB3cml0dGVuIGFzIHZhbD0t
eHh4IHZhbDI9LXh4eAoKU2luY2UgaWlvX2Zvcm1hdF92YWx1ZSgpIHVzZXMgYWJzKHZhbCkg
d2hlbiB2YWwyIDwgMC4KClRoaXMgZml4IGFsc28gbWFrZXMgaWlvX2NvbnZlcnRfcmF3X3Rv
X3Byb2Nlc3NlZCgpIHByb3Blcmx5IGhhbmRsZQpjaGFubmVsLXNjYWxlcyB1c2luZyB0aGlz
IHRoaXJkIG9wdGlvbi4KCkZpeGVzOiA0OGU0NGNlMGY4ODEgKCJpaW86aW5rZXJuOiBBZGQg
ZnVuY3Rpb24gdG8gcmVhZCB0aGUgcHJvY2Vzc2VkIHZhbHVlIikKQ2M6IE1hdHRlbyBNYXJ0
ZWxsaSA8bWF0dGVvbWFydGVsbGkzQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSGFucyBk
ZSBHb2VkZSA8aGFuc2dAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgaW4gdjQ6Ci0gTmV3IHBh
dGNoIGluIHY0IG9mIHRoaXMgcGF0Y2gtc2V0Ci0tLQogZHJpdmVycy9paW8vaW5rZXJuLmMg
fCAyMyArKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5r
ZXJuLmMgYi9kcml2ZXJzL2lpby9pbmtlcm4uYwppbmRleCBjMTc0ZWJiN2Q1ZTYuLjZjMTYy
MjQ2MTlmNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vaW5rZXJuLmMKKysrIGIvZHJpdmVy
cy9paW8vaW5rZXJuLmMKQEAgLTYwNCw3ICs2MDQsNyBAQCBzdGF0aWMgaW50IGlpb19jb252
ZXJ0X3Jhd190b19wcm9jZXNzZWRfdW5sb2NrZWQoc3RydWN0IGlpb19jaGFubmVsICpjaGFu
LAogewogCWludCBzY2FsZV90eXBlLCBzY2FsZV92YWwsIHNjYWxlX3ZhbDI7CiAJaW50IG9m
ZnNldF90eXBlLCBvZmZzZXRfdmFsLCBvZmZzZXRfdmFsMjsKLQlzNjQgcmF3NjQgPSByYXc7
CisJczY0IGRlbm9taW5hdG9yLCByYXc2NCA9IHJhdzsKIAogCW9mZnNldF90eXBlID0gaWlv
X2NoYW5uZWxfcmVhZChjaGFuLCAmb2Zmc2V0X3ZhbCwgJm9mZnNldF92YWwyLAogCQkJCSAg
ICAgICBJSU9fQ0hBTl9JTkZPX09GRlNFVCk7CkBAIC02NDgsMjAgKzY0OCwxNSBAQCBzdGF0
aWMgaW50IGlpb19jb252ZXJ0X3Jhd190b19wcm9jZXNzZWRfdW5sb2NrZWQoc3RydWN0IGlp
b19jaGFubmVsICpjaGFuLAogCQkqcHJvY2Vzc2VkID0gcmF3NjQgKiBzY2FsZV92YWwgKiBz
Y2FsZTsKIAkJYnJlYWs7CiAJY2FzZSBJSU9fVkFMX0lOVF9QTFVTX01JQ1JPOgotCQlpZiAo
c2NhbGVfdmFsMiA8IDApCi0JCQkqcHJvY2Vzc2VkID0gLXJhdzY0ICogc2NhbGVfdmFsICog
c2NhbGU7Ci0JCWVsc2UKLQkJCSpwcm9jZXNzZWQgPSByYXc2NCAqIHNjYWxlX3ZhbCAqIHNj
YWxlOwotCQkqcHJvY2Vzc2VkICs9IGRpdl9zNjQocmF3NjQgKiAoczY0KXNjYWxlX3ZhbDIg
KiBzY2FsZSwKLQkJCQkgICAgICAxMDAwMDAwTEwpOwotCQlicmVhazsKIAljYXNlIElJT19W
QUxfSU5UX1BMVVNfTkFOTzoKLQkJaWYgKHNjYWxlX3ZhbDIgPCAwKQotCQkJKnByb2Nlc3Nl
ZCA9IC1yYXc2NCAqIHNjYWxlX3ZhbCAqIHNjYWxlOwotCQllbHNlCi0JCQkqcHJvY2Vzc2Vk
ID0gcmF3NjQgKiBzY2FsZV92YWwgKiBzY2FsZTsKLQkJKnByb2Nlc3NlZCArPSBkaXZfczY0
KHJhdzY0ICogKHM2NClzY2FsZV92YWwyICogc2NhbGUsCi0JCQkJICAgICAgMTAwMDAwMDAw
MExMKTsKKwkJc3dpdGNoIChzY2FsZV90eXBlKSB7CisJCWNhc2UgSUlPX1ZBTF9JTlRfUExV
U19NSUNSTzogZGVub21pbmF0b3IgPSAxMDAwMDAwTEw7IGJyZWFrOworCQljYXNlIElJT19W
QUxfSU5UX1BMVVNfTkFOTzogZGVub21pbmF0b3IgPSAxMDAwMDAwMDAwTEw7IGJyZWFrOwor
CQl9CisJCSpwcm9jZXNzZWQgPSByYXc2NCAqIHNjYWxlICogYWJzKHNjYWxlX3ZhbCk7CisJ
CSpwcm9jZXNzZWQgKz0gZGl2X3M2NChyYXc2NCAqIHNjYWxlICogYWJzKHNjYWxlX3ZhbDIp
LCBkZW5vbWluYXRvcik7CisJCWlmIChzY2FsZV92YWwgPCAwIHx8IHNjYWxlX3ZhbDIgPCAw
KQorCQkJKnByb2Nlc3NlZCAqPSAtMTsKIAkJYnJlYWs7CiAJY2FzZSBJSU9fVkFMX0ZSQUNU
SU9OQUw6CiAJCSpwcm9jZXNzZWQgPSBkaXZfczY0KHJhdzY0ICogKHM2NClzY2FsZV92YWwg
KiBzY2FsZSwKLS0gCjIuNDkuMAoK
--------------OmK4ERs5QK0ZGRVzyGsojGAh
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-iio-consumers-Fix-offset-handling-in-iio_convert_raw.patch"
Content-Disposition: attachment;
 filename*0="0002-iio-consumers-Fix-offset-handling-in-iio_convert_raw.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2MmUxYzBkZDE4NjQ4ZWNmMjYyYmIyYjViNzQ2MGMzMzllNzUyMWM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDEwIEF1ZyAyMDI1IDIyOjQ4OjAxICswMjAwClN1YmplY3Q6IFtQQVRD
SCAyLzRdIGlpbzogY29uc3VtZXJzOiBGaXggb2Zmc2V0IGhhbmRsaW5nIGluCiBpaW9fY29u
dmVydF9yYXdfdG9fcHJvY2Vzc2VkKCkKCkZpeCBpaW9fY29udmVydF9yYXdfdG9fcHJvY2Vz
c2VkKCkgb2Zmc2V0IGhhbmRsaW5nIGZvciBjaGFubmVscyB3aXRob3V0CmEgc2NhbGUgYXR0
cmlidXRlLgoKVGhlIG9mZnNldCBoYXMgYmVlbiBhcHBsaWVkIHRvIHRoZSByYXc2NCB2YWx1
ZSBub3QgdG8gdGhlIG9yaWdpbmFsIHJhdwp2YWx1ZS4gVXNlIHRoZSByYXc2NCB2YWx1ZSBz
byB0aGF0IHRoZSBvZmZzZXQgaXMgdGFrZW4gaW50byBhY2NvdW50LgoKRml4ZXM6IDE0YjQ1
N2ZkZGUzOCAoImlpbzogaW5rZXJuOiBhcHBseSBjb25zdW1lciBzY2FsZSB3aGVuIG5vIGNo
YW5uZWwgc2NhbGUgaXMgYXZhaWxhYmxlIikKQ2M6IExpYW0gQmVndWluIDxsaWFtYmVndWlu
QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2VybmVs
Lm9yZz4KLS0tCkNoYW5nZXMgaW4gdjQ6Ci0gTmV3IHBhdGNoIGluIHY0IG9mIHRoaXMgcGF0
Y2gtc2V0Ci0tLQogZHJpdmVycy9paW8vaW5rZXJuLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9pbmtlcm4uYyBiL2RyaXZlcnMvaWlvL2lua2Vybi5jCmluZGV4IDZjMTYyMjQ2MTlm
NC4uOWY0M2FlNGI1YmRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbmtlcm4uYworKysg
Yi9kcml2ZXJzL2lpby9pbmtlcm4uYwpAQCAtNjM5LDcgKzYzOSw3IEBAIHN0YXRpYyBpbnQg
aWlvX2NvbnZlcnRfcmF3X3RvX3Byb2Nlc3NlZF91bmxvY2tlZChzdHJ1Y3QgaWlvX2NoYW5u
ZWwgKmNoYW4sCiAJCSAqIElmIG5vIGNoYW5uZWwgc2NhbGluZyBpcyBhdmFpbGFibGUgYXBw
bHkgY29uc3VtZXIgc2NhbGUgdG8KIAkJICogcmF3IHZhbHVlIGFuZCByZXR1cm4uCiAJCSAq
LwotCQkqcHJvY2Vzc2VkID0gcmF3ICogc2NhbGU7CisJCSpwcm9jZXNzZWQgPSByYXc2NCAq
IHNjYWxlOwogCQlyZXR1cm4gMDsKIAl9CiAKLS0gCjIuNDkuMAoK
--------------OmK4ERs5QK0ZGRVzyGsojGAh
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-iio-consumers-Add-an-iio_multiply_value-helper-funct.patch"
Content-Disposition: attachment;
 filename*0="0003-iio-consumers-Add-an-iio_multiply_value-helper-funct.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzZWNkOTUzNDM3OTUzMmI2OWZkYjkwNTgwN2E1NmYyMzFhYTE5MTM1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDEwIEF1ZyAyMDI1IDIyOjQwOjQ1ICswMjAwClN1YmplY3Q6IFtQQVRD
SCAzLzRdIGlpbzogY29uc3VtZXJzOiBBZGQgYW4gaWlvX211bHRpcGx5X3ZhbHVlKCkgaGVs
cGVyCiBmdW5jdGlvbgoKVGhlIGNoYW5uZWwtc2NhbGUgaGFuZGxpbmcgaW4gaWlvX2NvbnZl
cnRfcmF3X3RvX3Byb2Nlc3NlZCgpIGluIGVzc2VuY2UKZG9lcyB0aGUgZm9sbG93aW5nOgoK
cHJvY2Vzc2VkICA9IHJhdyAqIGNhbGxlci1wcm92aWRlZC1zY2FsZSAqIGNoYW5uZWwtc2Nh
bGUKCldoaWNoIGNhbiBhbHNvIGJlIHdyaXR0ZW4gYXM6CgptdWx0aXBsaWVyID0gcmF3ICog
Y2FsbGVyLXByb3ZpZGVkLXNjYWxlCmlpby12YWwgICAgPSBjaGFubmVsLXNjYWxlCnByb2Nl
c3NlZCAgPSBtdWx0aXBsaWVyICogaWlvLXZhbAoKV2hlcmUgaWlvdmFsIGlzIGEgc2V0IG9m
IElJT19WQUxfKiB0eXBlICsgdmFsICsgdmFsMiBpbnRlZ2VycywgYmVpbmcKYWJsZSB0byBo
YW5kbGUgbXVsdGlwbGljYXRpb24gb2YgaWlvLXZhbHVlcyBsaWtlIHRoaXMgaXMgc29tZXRo
aW5nCndoaWNoIGlzIHVzZWZ1bCB0byBoYXZlIGluIGdlbmVyYWwgYW5kIGFzIHByZXZpb3Vz
IGJ1Z2ZpeGVzIHRvCmlpb19jb252ZXJ0X3Jhd190b19wcm9jZXNzZWQoKSBoYXZlIHNob3du
IGFsc28gdHJpY2t5IHRvIGltcGxlbWVudC4KClNwbGl0IHRoZSBpaW8tdmFsdWUgbXVsdGlw
bGljYXRpb24gY29kZSBmcm9tIGlpb19jb252ZXJ0X3Jhd190b19wcm9jZXNzZWQoKQpvdXQg
aW50byBhIG5ldyBpaW9fbXVsdGlwbHlfdmFsdWUoKSBoZWxwZXIuIFRoaXMgc2VydmVzIG11
bHRpcGxlIHB1cnBvc2VzOgoKMS4gSGF2aW5nIHRoaXMgc3BsaXQgb3V0IGFsbG93cyB3cml0
aW5nIGEga3VuaXQgdGVzdCBmb3IgdGhpcy4KMi4gSGF2aW5nIHRoaXMgc3BsaXQgb3V0IGFs
bG93cyByZS11c2UgdG8gZ2V0IGJldHRlciBwcmVjaXNpb24KICAgd2hlbiBzY2FsaW5nIHZh
bHVlcyBpbiBpaW9fcmVhZF9jaGFubmVsX3Byb2Nlc3NlZF9zY2FsZSgpLgoKU2lnbmVkLW9m
Zi1ieTogSGFucyBkZSBHb2VkZSA8aGFuc2dAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgaW4g
djQ6Ci0gTmV3IHBhdGNoIGluIHY0IG9mIHRoaXMgcGF0Y2gtc2V0Ci0tLQogZHJpdmVycy9p
aW8vaW5rZXJuLmMgICAgICAgICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLQogaW5jbHVkZS9saW51eC9paW8vY29uc3VtZXIuaCB8IDE4ICsrKysrKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5rZXJuLmMgYi9kcml2ZXJzL2lpby9pbmtlcm4u
YwppbmRleCA5ZjQzYWU0YjViZGUuLmUzZjFkMDk0NGUyOCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9paW8vaW5rZXJuLmMKKysrIGIvZHJpdmVycy9paW8vaW5rZXJuLmMKQEAgLTU5OCwxMyAr
NTk4LDQ2IEBAIGludCBpaW9fcmVhZF9jaGFubmVsX2F2ZXJhZ2VfcmF3KHN0cnVjdCBpaW9f
Y2hhbm5lbCAqY2hhbiwgaW50ICp2YWwpCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChpaW9fcmVh
ZF9jaGFubmVsX2F2ZXJhZ2VfcmF3KTsKIAoraW50IGlpb19tdWx0aXBseV92YWx1ZShpbnQg
KnJlc3VsdCwgczY0IG11bHRpcGxpZXIsCisJCSAgICAgICB1bnNpZ25lZCBpbnQgdHlwZSwg
aW50IHZhbCwgaW50IHZhbDIpCit7CisJczY0IGRlbm9taW5hdG9yOworCisJc3dpdGNoICh0
eXBlKSB7CisJY2FzZSBJSU9fVkFMX0lOVDoKKwkJKnJlc3VsdCA9IG11bHRpcGxpZXIgKiB2
YWw7CisJCXJldHVybiBJSU9fVkFMX0lOVDsKKwljYXNlIElJT19WQUxfSU5UX1BMVVNfTUlD
Uk86CisJY2FzZSBJSU9fVkFMX0lOVF9QTFVTX05BTk86CisJCXN3aXRjaCAodHlwZSkgewor
CQljYXNlIElJT19WQUxfSU5UX1BMVVNfTUlDUk86IGRlbm9taW5hdG9yID0gMTAwMDAwMExM
OyBicmVhazsKKwkJY2FzZSBJSU9fVkFMX0lOVF9QTFVTX05BTk86IGRlbm9taW5hdG9yID0g
MTAwMDAwMDAwMExMOyBicmVhazsKKwkJfQorCQkqcmVzdWx0ID0gbXVsdGlwbGllciAqIGFi
cyh2YWwpOworCQkqcmVzdWx0ICs9IGRpdl9zNjQobXVsdGlwbGllciAqIGFicyh2YWwyKSwg
ZGVub21pbmF0b3IpOworCQlpZiAodmFsIDwgMCB8fCB2YWwyIDwgMCkKKwkJCSpyZXN1bHQg
Kj0gLTE7CisJCXJldHVybiBJSU9fVkFMX0lOVDsKKwljYXNlIElJT19WQUxfRlJBQ1RJT05B
TDoKKwkJKnJlc3VsdCA9IGRpdl9zNjQobXVsdGlwbGllciAqIHZhbCwgdmFsMik7CisJCXJl
dHVybiBJSU9fVkFMX0lOVDsKKwljYXNlIElJT19WQUxfRlJBQ1RJT05BTF9MT0cyOgorCQkq
cmVzdWx0ID0gKG11bHRpcGxpZXIgKiB2YWwpID4+IHZhbDI7CisJCXJldHVybiBJSU9fVkFM
X0lOVDsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLUVJTlZBTDsKKwl9Cit9CitFWFBPUlRfU1lN
Qk9MX0dQTChpaW9fbXVsdGlwbHlfdmFsdWUpOworCiBzdGF0aWMgaW50IGlpb19jb252ZXJ0
X3Jhd190b19wcm9jZXNzZWRfdW5sb2NrZWQoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLAog
CQkJCQkJIGludCByYXcsIGludCAqcHJvY2Vzc2VkLAogCQkJCQkJIHVuc2lnbmVkIGludCBz
Y2FsZSkKIHsKIAlpbnQgc2NhbGVfdHlwZSwgc2NhbGVfdmFsLCBzY2FsZV92YWwyOwogCWlu
dCBvZmZzZXRfdHlwZSwgb2Zmc2V0X3ZhbCwgb2Zmc2V0X3ZhbDI7Ci0JczY0IGRlbm9taW5h
dG9yLCByYXc2NCA9IHJhdzsKKwlzNjQgcmF3NjQgPSByYXc7CisJaW50IHJldDsKIAogCW9m
ZnNldF90eXBlID0gaWlvX2NoYW5uZWxfcmVhZChjaGFuLCAmb2Zmc2V0X3ZhbCwgJm9mZnNl
dF92YWwyLAogCQkJCSAgICAgICBJSU9fQ0hBTl9JTkZPX09GRlNFVCk7CkBAIC02NDMsMzEg
KzY3NiwxMCBAQCBzdGF0aWMgaW50IGlpb19jb252ZXJ0X3Jhd190b19wcm9jZXNzZWRfdW5s
b2NrZWQoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLAogCQlyZXR1cm4gMDsKIAl9CiAKLQlz
d2l0Y2ggKHNjYWxlX3R5cGUpIHsKLQljYXNlIElJT19WQUxfSU5UOgotCQkqcHJvY2Vzc2Vk
ID0gcmF3NjQgKiBzY2FsZV92YWwgKiBzY2FsZTsKLQkJYnJlYWs7Ci0JY2FzZSBJSU9fVkFM
X0lOVF9QTFVTX01JQ1JPOgotCWNhc2UgSUlPX1ZBTF9JTlRfUExVU19OQU5POgotCQlzd2l0
Y2ggKHNjYWxlX3R5cGUpIHsKLQkJY2FzZSBJSU9fVkFMX0lOVF9QTFVTX01JQ1JPOiBkZW5v
bWluYXRvciA9IDEwMDAwMDBMTDsgYnJlYWs7Ci0JCWNhc2UgSUlPX1ZBTF9JTlRfUExVU19O
QU5POiBkZW5vbWluYXRvciA9IDEwMDAwMDAwMDBMTDsgYnJlYWs7Ci0JCX0KLQkJKnByb2Nl
c3NlZCA9IHJhdzY0ICogc2NhbGUgKiBhYnMoc2NhbGVfdmFsKTsKLQkJKnByb2Nlc3NlZCAr
PSBkaXZfczY0KHJhdzY0ICogc2NhbGUgKiBhYnMoc2NhbGVfdmFsMiksIGRlbm9taW5hdG9y
KTsKLQkJaWYgKHNjYWxlX3ZhbCA8IDAgfHwgc2NhbGVfdmFsMiA8IDApCi0JCQkqcHJvY2Vz
c2VkICo9IC0xOwotCQlicmVhazsKLQljYXNlIElJT19WQUxfRlJBQ1RJT05BTDoKLQkJKnBy
b2Nlc3NlZCA9IGRpdl9zNjQocmF3NjQgKiAoczY0KXNjYWxlX3ZhbCAqIHNjYWxlLAotCQkJ
CSAgICAgc2NhbGVfdmFsMik7Ci0JCWJyZWFrOwotCWNhc2UgSUlPX1ZBTF9GUkFDVElPTkFM
X0xPRzI6Ci0JCSpwcm9jZXNzZWQgPSAocmF3NjQgKiAoczY0KXNjYWxlX3ZhbCAqIHNjYWxl
KSA+PiBzY2FsZV92YWwyOwotCQlicmVhazsKLQlkZWZhdWx0OgotCQlyZXR1cm4gLUVJTlZB
TDsKLQl9CisJcmV0ID0gaWlvX211bHRpcGx5X3ZhbHVlKHByb2Nlc3NlZCwgcmF3NjQgKiBz
Y2FsZSwKKwkJCQkgc2NhbGVfdHlwZSwgc2NhbGVfdmFsLCBzY2FsZV92YWwyKTsKKwlpZiAo
cmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9paW8vY29uc3VtZXIuaCBiL2luY2x1ZGUvbGludXgvaWlvL2NvbnN1
bWVyLmgKaW5kZXggNmE0NDc5NjE2NDc5Li5jOGM2MjYxYzgxZjkgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9paW8vY29u
c3VtZXIuaApAQCAtMzgxLDYgKzM4MSwyNCBAQCBpbnQgaWlvX3JlYWRfY2hhbm5lbF9vZmZz
ZXQoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLCBpbnQgKnZhbCwKIGludCBpaW9fcmVhZF9j
aGFubmVsX3NjYWxlKHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwgaW50ICp2YWwsCiAJCQkg
ICBpbnQgKnZhbDIpOwogCisvKioKKyAqIGlpb19tdWx0aXBseV92YWx1ZSgpIC0gTXVsdGlw
bHkgYW4gaWlvIHZhbHVlCisgKiBAcmVzdWx0OglEZXN0aW5hdGlvbiBwb2ludGVyIGZvciB0
aGUgbXVsdGlwbGljYXRpb24gcmVzdWx0CisgKiBAbXVsdGlwbGllcjoJTXVsdGlwbGllci4K
KyAqIEB0eXBlOglPbmUgb2YgdGhlIElJT19WQUxfKiBjb25zdGFudHMuIFRoaXMgZGVjaWRl
cyBob3cgdGhlIHZhbAorICoJCWFuZCB2YWwyIHBhcmFtZXRlcnMgYXJlIGludGVycHJldGVk
LgorICogQHZhbDoJVmFsdWUgYmVpbmcgbXVsdGlwbGllZC4KKyAqIEB2YWwyOglWYWx1ZSBi
ZWluZyBtdWx0aXBsaWVkLiB2YWwyIHVzZSBkZXBlbmRzIG9uIHR5cGUuCisgKgorICogTXVs
dGlwbHkgYW4gaWlvIHZhbHVlIHdpdGggYSBzNjQgbXVsdGlwbGllciBzdG9yaW5nIHRoZSBy
ZXN1bHQgYXMKKyAqIElJT19WQUxfSU5ULiBUaGlzIGlzIHR5cGljYWxseSB1c2VkIGZvciBz
Y2FsaW5nLgorICoKKyAqIFJldHVybnM6CisgKiBJSU9fVkFMX0lOVCBvbiBzdWNjZXNzIG9y
IGEgbmVnYXRpdmUgZXJyb3ItbnVtYmVyIG9uIGZhaWx1cmUuCisgKi8KK2ludCBpaW9fbXVs
dGlwbHlfdmFsdWUoaW50ICpyZXN1bHQsIHM2NCBtdWx0aXBsaWVyLAorCQkgICAgICAgdW5z
aWduZWQgaW50IHR5cGUsIGludCB2YWwsIGludCB2YWwyKTsKKwogLyoqCiAgKiBpaW9fY29u
dmVydF9yYXdfdG9fcHJvY2Vzc2VkKCkgLSBDb252ZXJ0cyBhIHJhdyB2YWx1ZSB0byBhIHBy
b2Nlc3NlZCB2YWx1ZQogICogQGNoYW46CQlUaGUgY2hhbm5lbCBiZWluZyBxdWVyaWVkCi0t
IAoyLjQ5LjAKCg==
--------------OmK4ERs5QK0ZGRVzyGsojGAh
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-iio-Improve-iio_read_channel_processed_scale-precisi.patch"
Content-Disposition: attachment;
 filename*0="0004-iio-Improve-iio_read_channel_processed_scale-precisi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmODM3Mjk1N2M2YjUxYWUzMGU5NTAxNWUxNTFkNDJhZWM3MDljMTc5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDEwIEF1ZyAyMDI1IDIzOjAzOjQxICswMjAwClN1YmplY3Q6IFtQQVRD
SCA0LzRdIGlpbzogSW1wcm92ZSBpaW9fcmVhZF9jaGFubmVsX3Byb2Nlc3NlZF9zY2FsZSgp
IHByZWNpc2lvbgoKQmVmb3JlIHRoaXMgY2hhbmdlIGlpb19yZWFkX2NoYW5uZWxfcHJvY2Vz
c2VkX3NjYWxlKCkgYWx3YXlzIGFzc3VtZXMgdGhhdApjaGFubmVscyB3aGljaCBhZHZlcnRp
c2UgSUlPX0NIQU5fSU5GT19QUk9DRVNTRUQgY2FwYWJpbGl0eSByZXR1cm4KSUlPX1ZBTF9J
TlQgb24gc3VjY2Vzcy4KCklnbm9yaW5nIGFueSBmcmFjdGlvbmFsIHZhbHVlcyBmcm9tIGRy
aXZlcnMgd2hpY2ggcmV0dXJuCklJT19WQUxfSU5UX1BMVVNfTUlDUk8gLyBJSU9fVkFMX0lO
VF9QTFVTX05BTk8uIFRoZXNlIGZyYWN0aW9uYWwgdmFsdWVzCm1pZ2h0IGJlY29tZSBub24g
ZnJhY3Rpb25hbCBhZnRlciBzY2FsaW5nIHNvIHRoZXNlIHNob3VsZCBiZSB0YWtlbiBpbnRv
CmFjY291bnQgZm9yIGJldHRlciBwcmVjaXNpb24uCgpVc2UgdGhlIG5ldyBpaW9fbXVsdGlw
bHlfdmFsdWUoKSBoZWxwZXIgdG8gZG8gcHJvcGVyIHNjYWxpbmcgdGFraW5nCnRoZSBmcmFj
dGlvbmlvbmFsIHZhbHVlcyBpbnRvIGFjY291bnQuCgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRl
IEdvZWRlIDxoYW5zZ0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyBpbiB2NAotIFVzZSB0aGUg
bmV3IGlpb19tdWx0aXBseV92YWx1ZSgpIGhlbHBlciBpbnN0ZWFkIG9mIERZSSBjb2RlCi0t
LQogZHJpdmVycy9paW8vaW5rZXJuLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vaW5rZXJuLmMgYi9kcml2ZXJzL2lpby9pbmtlcm4uYwppbmRleCBlM2YxZDA5NDRlMjgu
LmFkNjVhMDNlMTY4NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vaW5rZXJuLmMKKysrIGIv
ZHJpdmVycy9paW8vaW5rZXJuLmMKQEAgLTcyMSwyMCArNzIxLDE5IEBAIGludCBpaW9fcmVh
ZF9jaGFubmVsX3Byb2Nlc3NlZF9zY2FsZShzdHJ1Y3QgaWlvX2NoYW5uZWwgKmNoYW4sIGlu
dCAqdmFsLAogCQkJCSAgICAgdW5zaWduZWQgaW50IHNjYWxlKQogewogCXN0cnVjdCBpaW9f
ZGV2X29wYXF1ZSAqaWlvX2Rldl9vcGFxdWUgPSB0b19paW9fZGV2X29wYXF1ZShjaGFuLT5p
bmRpb19kZXYpOwotCWludCByZXQ7CisJaW50IHJldCwgdmFsMjsKIAogCWd1YXJkKG11dGV4
KSgmaWlvX2Rldl9vcGFxdWUtPmluZm9fZXhpc3RfbG9jayk7CiAJaWYgKCFjaGFuLT5pbmRp
b19kZXYtPmluZm8pCiAJCXJldHVybiAtRU5PREVWOwogCiAJaWYgKGlpb19jaGFubmVsX2hh
c19pbmZvKGNoYW4tPmNoYW5uZWwsIElJT19DSEFOX0lORk9fUFJPQ0VTU0VEKSkgewotCQly
ZXQgPSBpaW9fY2hhbm5lbF9yZWFkKGNoYW4sIHZhbCwgTlVMTCwKKwkJcmV0ID0gaWlvX2No
YW5uZWxfcmVhZChjaGFuLCB2YWwsICZ2YWwyLAogCQkJCSAgICAgICBJSU9fQ0hBTl9JTkZP
X1BST0NFU1NFRCk7CiAJCWlmIChyZXQgPCAwKQogCQkJcmV0dXJuIHJldDsKLQkJKnZhbCAq
PSBzY2FsZTsKIAotCQlyZXR1cm4gcmV0OworCQlyZXR1cm4gaWlvX211bHRpcGx5X3ZhbHVl
KHZhbCwgc2NhbGUsIHJldCwgKnZhbCwgdmFsMik7CiAJfSBlbHNlIHsKIAkJcmV0ID0gaWlv
X2NoYW5uZWxfcmVhZChjaGFuLCB2YWwsIE5VTEwsIElJT19DSEFOX0lORk9fUkFXKTsKIAkJ
aWYgKHJldCA8IDApCi0tIAoyLjQ5LjAKCg==

--------------OmK4ERs5QK0ZGRVzyGsojGAh--

