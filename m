Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2447A448C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjIRIXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Sep 2023 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjIRIX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2023 04:23:29 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220263A8C;
        Mon, 18 Sep 2023 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695025231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVlOiVO9dPN994CwJpPCJsTlJCMI2ipu9TpHyfk87js=;
        b=VhSBQlUktsCNBNQTS6gS/brrV8uMEuSdgWAsK2k4AZ9SKqxTsaRM4Y/NVH93uPVOD0EdMO
        b9M5kqBj9IbhYlDLVFxdSd7vXq6mW4dWRh4HGNRMvdunxlJQUOmHHSn/S307X95gwQd5JI
        mfUGls4NaotQAVcgNFRWVa0uHIjvAFo=
Message-ID: <a31817a460f8ee66c9d460e97aeea62b2bcfbc51.camel@crapouillou.net>
Subject: Re: [PATCH for-next v2 02/10] PM: Update EXPORT_*_DEV_PM_OPS() to
 EXPORT_*_RUNTIME_PM_OPS()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
        len.brown@intel.com, pavel@ucw.cz, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        rmfrfs@gmail.com, jean-baptiste.maneyrol@tdk.com, lee@kernel.org,
        laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Date:   Mon, 18 Sep 2023 10:20:29 +0200
In-Reply-To: <20230918080951.3615-3-raag.jadav@intel.com>
References: <20230918080951.3615-1-raag.jadav@intel.com>
         <20230918080951.3615-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUmFhZywKCkxlIGx1bmRpIDE4IHNlcHRlbWJyZSAyMDIzIMOgIDEzOjM5ICswNTMwLCBSYWFn
IEphZGF2IGEgw6ljcml0wqA6Cj4gUmVuYW1lIEVYUE9SVF8qX0RFVl9QTV9PUFMoKSBtYWNyb3Mg
dG8gRVhQT1JUXypfUlVOVElNRV9QTV9PUFMoKQo+IGFuZCB3aGlsZSBhdCBpdCwgbW92ZSB0aGVt
IHRvIHBtX3J1bnRpbWUuaC4KPiBUaGlzIGlzIGRvbmUgaW4gY29uanVuY3Rpb24gd2l0aCB0aGUg
aW50cm9kdWN0aW9uIG9mCj4gRVhQT1JUXypfU0lNUExFX1BNX09QUygpIHNldCBvZiBtYWNyb3Ms
IHRvIG1ha2UgdGhpbmdzIGxlc3MKPiBjb25mdXNpbmcuCj4gVGhpcyBtYWtlcyBib3RoIF9SVU5U
SU1FXyBhbmQgX1NJTVBMRV8gdmFyaWFudHMgb2YgZXhwb3J0IG1hY3JvcyBtb3JlCj4gZGlzdGlu
Z3Vpc2hhYmxlIGFuZCBzZWxmIGV4cGxhbmF0b3J5LgoKV2VsbCBJIGRvbid0IHJlYWxseSBhZ3Jl
ZSB3aXRoIHRoaXMgb25lLiBUaGUgRVhQT1JUXypfREVWX1BNX09QUygpIGNhbgpiZSB1c2VkIHdp
dGggYW55IGNhbGxiYWNrIHlvdSBuZWVkLCBub3QganVzdCB0aGUgdHlwaWNhbCBydW50aW1lLVBN
CmNhbGxiYWNrcy4gVGhleSBhcmUgZ2VuZXJpYyBQTSBtYWNyb3MuCgpDaGVlcnMsCi1QYXVsCgo+
IAo+IFNpZ25lZC1vZmYtYnk6IFJhYWcgSmFkYXYgPHJhYWcuamFkYXZAaW50ZWwuY29tPgo+IC0t
LQo+IMKgaW5jbHVkZS9saW51eC9wbS5owqDCoMKgwqDCoMKgwqDCoCB8wqAgNSAtLS0tLQo+IMKg
aW5jbHVkZS9saW51eC9wbV9ydW50aW1lLmggfCAxMyArKysrKysrKystLS0tCj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9wbS5oIGIvaW5jbHVkZS9saW51eC9wbS5oCj4gaW5kZXggNmU3YWI2
OTUwYWQxLi45YWIwNTFmM2EzNTEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbS5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC9wbS5oCj4gQEAgLTM5OCwxMSArMzk4LDYgQEAgY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgbmFtZSA9IHsgXAo+IMKgI2RlZmluZSBfRVhQT1JUX1NJTVBMRV9QTV9P
UFMobmFtZSwgbGljZW5zZSwgbnMpwqDCoMKgwqDCoMKgwqBfUE1fT1BTKG5hbWUsCj4gbGljZW5z
ZSwgbnMpCj4gwqAjZW5kaWYKPiDCoAo+IC0jZGVmaW5lCj4gRVhQT1JUX0RFVl9QTV9PUFMobmFt
ZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgX0VYUE9SVF9SVU5USU0KPiBFX1BNX09QUyhuYW1lLCAiIiwgIiIpCj4gLSNkZWZp
bmUKPiBFWFBPUlRfR1BMX0RFVl9QTV9PUFMobmFtZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgX0VYUE9SVF9SVU5USU1FX1BNX09QUwo+IChuYW1lLCAiR1BMIiwgIiIp
Cj4gLSNkZWZpbmUgRVhQT1JUX05TX0RFVl9QTV9PUFMobmFtZSwKPiBucynCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgX0VYUE9SVF9SVU5USU1FX1BNX09QUyhuYW1lLCAiIiwgI25z
KQo+IC0jZGVmaW5lIEVYUE9SVF9OU19HUExfREVWX1BNX09QUyhuYW1lLAo+IG5zKcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgX0VYUE9SVF9SVU5USU1FX1BNX09QUyhuYW1lLCAiR1BMIiwgI25z
KQo+IC0KPiDCoCNkZWZpbmUKPiBFWFBPUlRfU0lNUExFX1BNX09QUyhuYW1lKcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9FWFBPUlRfU0lNUExFX1BNX09QUygKPiBu
YW1lLCAiIiwgIiIpCj4gwqAjZGVmaW5lCj4gRVhQT1JUX0dQTF9TSU1QTEVfUE1fT1BTKG5hbWUp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9FWFBPUlRfU0lNUExFX1BNX09QUygK
PiBuYW1lLCAiR1BMIiwgIiIpCj4gwqAjZGVmaW5lIEVYUE9SVF9OU19TSU1QTEVfUE1fT1BTKG5h
bWUsCj4gbnMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9FWFBPUlRfU0lNUExFX1BNX09Q
UyhuYW1lLCAiIiwgI25zKQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BtX3J1bnRpbWUu
aCBiL2luY2x1ZGUvbGludXgvcG1fcnVudGltZS5oCj4gaW5kZXggN2M5YjM1NDQ4NTYzLi4wYjcz
YjAwYmQ1OWYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbV9ydW50aW1lLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3BtX3J1bnRpbWUuaAo+IEBAIC0yMiw2ICsyMiwxMSBAQAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzYWdlX2NvdW50ICovCj4gwqAjZGVmaW5lIFJQTV9B
VVRPwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgwOMKgwqDCoMKgLyogVXNlIGF1dG9z
dXNwZW5kX2RlbGF5ICovCj4gwqAKPiArI2RlZmluZQo+IEVYUE9SVF9SVU5USU1FX1BNX09QUyhu
YW1lKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfRVhQT1JUX1JVTlRJ
TUVfUE1fT1BTCj4gKG5hbWUsICIiLCAiIikKPiArI2RlZmluZQo+IEVYUE9SVF9HUExfUlVOVElN
RV9QTV9PUFMobmFtZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBfRVhQT1JUX1JVTlRJTQo+IEVfUE1fT1BTKG5hbWUsICJHUEwiLCAiIikKPiArI2RlZmlu
ZSBFWFBPUlRfTlNfUlVOVElNRV9QTV9PUFMobmFtZSwKPiBucynCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoF9FWFBPUlRfUlVOVElNRV9QTV9PUFMobmFtZSwgIiIsICNucykKPiArI2RlZmluZSBF
WFBPUlRfTlNfR1BMX1JVTlRJTUVfUE1fT1BTKG5hbWUsCj4gbnMpwqDCoMKgwqDCoMKgwqDCoMKg
X0VYUE9SVF9SVU5USU1FX1BNX09QUyhuYW1lLCAiR1BMIiwgI25zKQo+ICsKPiDCoC8qCj4gwqAg
KiBVc2UgdGhpcyBmb3IgZGVmaW5pbmcgYSBzZXQgb2YgUE0gb3BlcmF0aW9ucyB0byBiZSB1c2Vk
IGluIGFsbAo+IHNpdHVhdGlvbnMKPiDCoCAqIChzeXN0ZW0gc3VzcGVuZCwgaGliZXJuYXRpb24g
b3IgcnVudGltZSBQTSkuCj4gQEAgLTQwLDE5ICs0NSwxOSBAQAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdW1lX2ZuLCBpZGxlX2ZuKQo+
IMKgCj4gwqAjZGVmaW5lIEVYUE9SVF9SVU5USU1FX0RFVl9QTV9PUFMobmFtZSwgc3VzcGVuZF9m
biwgcmVzdW1lX2ZuLAo+IGlkbGVfZm4pIFwKPiAtwqDCoMKgwqDCoMKgwqBFWFBPUlRfREVWX1BN
X09QUyhuYW1lKSA9IHsgXAo+ICvCoMKgwqDCoMKgwqDCoEVYUE9SVF9SVU5USU1FX1BNX09QUyhu
YW1lKSA9IHsgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUlVOVElNRV9QTV9P
UFMoc3VzcGVuZF9mbiwgcmVzdW1lX2ZuLCBpZGxlX2ZuKSBcCj4gwqDCoMKgwqDCoMKgwqDCoH0K
PiDCoCNkZWZpbmUgRVhQT1JUX0dQTF9SVU5USU1FX0RFVl9QTV9PUFMobmFtZSwgc3VzcGVuZF9m
biwgcmVzdW1lX2ZuLAo+IGlkbGVfZm4pIFwKPiAtwqDCoMKgwqDCoMKgwqBFWFBPUlRfR1BMX0RF
Vl9QTV9PUFMobmFtZSkgPSB7IFwKPiArwqDCoMKgwqDCoMKgwqBFWFBPUlRfR1BMX1JVTlRJTUVf
UE1fT1BTKG5hbWUpID0geyBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBSVU5U
SU1FX1BNX09QUyhzdXNwZW5kX2ZuLCByZXN1bWVfZm4sIGlkbGVfZm4pIFwKPiDCoMKgwqDCoMKg
wqDCoMKgfQo+IMKgI2RlZmluZSBFWFBPUlRfTlNfUlVOVElNRV9ERVZfUE1fT1BTKG5hbWUsIHN1
c3BlbmRfZm4sIHJlc3VtZV9mbiwKPiBpZGxlX2ZuLCBucykgXAo+IC3CoMKgwqDCoMKgwqDCoEVY
UE9SVF9OU19ERVZfUE1fT1BTKG5hbWUsIG5zKSA9IHsgXAo+ICvCoMKgwqDCoMKgwqDCoEVYUE9S
VF9OU19SVU5USU1FX1BNX09QUyhuYW1lLCBucykgPSB7IFwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFJVTlRJTUVfUE1fT1BTKHN1c3BlbmRfZm4sIHJlc3VtZV9mbiwgaWRsZV9m
bikgXAo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAjZGVmaW5lIEVYUE9SVF9OU19HUExfUlVOVElN
RV9ERVZfUE1fT1BTKG5hbWUsIHN1c3BlbmRfZm4sCj4gcmVzdW1lX2ZuLCBpZGxlX2ZuLCBucykg
XAo+IC3CoMKgwqDCoMKgwqDCoEVYUE9SVF9OU19HUExfREVWX1BNX09QUyhuYW1lLCBucykgPSB7
IFwKPiArwqDCoMKgwqDCoMKgwqBFWFBPUlRfTlNfR1BMX1JVTlRJTUVfUE1fT1BTKG5hbWUsIG5z
KSA9IHsgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUlVOVElNRV9QTV9PUFMo
c3VzcGVuZF9mbiwgcmVzdW1lX2ZuLCBpZGxlX2ZuKSBcCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAoK

