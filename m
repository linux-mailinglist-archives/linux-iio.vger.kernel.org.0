Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561A561DF9
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiF3Oc4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiF3Ocl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 10:32:41 -0400
X-Greylist: delayed 14443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 07:15:42 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62D57260
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 07:15:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 9490649675E;
        Thu, 30 Jun 2022 16:15:11 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id Krt0DxeNYzq0; Thu, 30 Jun 2022 16:15:11 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b7c0:8100:725c:297:eb88:6c8f])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu, 30 Jun 2022 16:15:11 +0200 (CEST)
Message-ID: <2ed20f22-1628-9596-b6a7-fcad250984f1@debian.org>
Date:   Thu, 30 Jun 2022 16:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
References: <20220630063528.205327-1-ukleinek@debian.org>
 <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
 <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
 <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
In-Reply-To: <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------01M65Tha302lioebOw0KdBUP"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------01M65Tha302lioebOw0KdBUP
Content-Type: multipart/mixed; boundary="------------54hoEkZCKYwK1RvsjLMk6bxg";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio <linux-iio@vger.kernel.org>, Yves-Alexis Perez <corsac@debian.org>
Message-ID: <2ed20f22-1628-9596-b6a7-fcad250984f1@debian.org>
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
References: <20220630063528.205327-1-ukleinek@debian.org>
 <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
 <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
 <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>
In-Reply-To: <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>

--------------54hoEkZCKYwK1RvsjLMk6bxg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNi8zMC8yMiAxMjoyNiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUaHUsIEp1
biAzMCwgMjAyMiBhdCAxMjoyNSBQTSBVd2UgS2xlaW5lLUvDtm5pZyA8dWtsZWluZWtAZGVi
aWFuLm9yZz4gd3JvdGU6DQo+PiBPbiA2LzMwLzIyIDA5OjE3LCBBbmR5IFNoZXZjaGVua28g
d3JvdGU6DQo+Pj4gT24gVGh1LCBKdW4gMzAsIDIwMjIgYXQgODo1OCBBTSBVd2UgS2xlaW5l
LUvDtm5pZyA8dWtsZWluZWtAZGViaWFuLm9yZz4gd3JvdGU6DQo+Pj4+DQo+Pj4+IERvbid0
IGVtaXQgYSBtZXNzYWdlIGZvciAtRU5PTUVNLCB0aGUga2VybmVsIGlzIGFscmVhZHkgbG91
ZCBlbm91Z2ggaW4NCj4+Pj4gdGhpcyBjYXNlLiBBZGQgYSBtZXNzYWdlIGlmIGdldHRpbmcg
dGhlIEdQSU8gb3IgcmVnaXN0ZXJpbmcgdGhlIGlpbw0KPj4+PiBkZXZpY2UgZmFpbHMgYW5k
IHVzZSBkZXZfZXJyX3Byb2JlIGZvciBpbXByb3ZlZCBiZWhhdmlvdXIgb24NCj4+Pj4gLUVQ
Uk9CRV9ERUZFUi4NCj4+Pg0KPj4+IFdoeSBkbyB3ZSBuZWVkIGFkZGl0aW9uYWwgbWVzc2Fn
ZXM/DQo+Pg0KPj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gRG8geW91IHJl
YWxseSB3b25kZXIgd2h5IHRoZXJlIGlzIGENCj4+IGJlbmVmaXQgb2YgYW4gZXJyb3IgbWVz
c2FnZSBpZiBhIHJlc291cmNlIGFsbG9jYXRpb24gaW4gcHJvYmUgZmFpbHM/DQo+Pg0KPj4g
Q3VycmVudCBzdGF0ZSBpcyB0aGF0IGZvciBZdmVzLUFsZXhpcyAob24gQ2M6KSB0aGUgZHJp
dmVyIGlzIHNpbGVudCBidXQNCj4+IHVuYm91bmQuIEkgZ3Vlc3MgdGhhdCdzIGJlY2F1c2Ug
Z3Bpb2RfZ2V0IGZhaWxzLCBidXQgc2VlaW5nIGENCj4+IGNvbmZpcm1hdGlvbiBpbiB0aGUg
a2VybmVsIGxvZyB3b3VsZCBiZSBuaWNlLg0KPj4NCj4+PiBUaGV5IHNob3VsZCBiZSBzcGxp
dCBpbiBhIHNlcGFyYXRlIHBhdGNoLCBwZXJoYXBzLCB3aXRoIHRoZSBleHBsYW5hdGlvbi4N
Cj4+Pg0KPj4+IEFjdHVhbGx5IHRoZSByZXN0IEkgd291bGQgc3BsaXQgdG8gdHdvOiBjb252
ZXJ0aW5nIHRvIGRldl9lcnJfcHJvYmUoKQ0KPj4+IGluIHRoZSBjYXNlIHdoZXJlIGl0J3Mg
bm90IHJpZ2h0IG5vdywgYW5kIGRyb3BwaW5nIEVOT01FTSBtZXNzYWdlLg0KPj4NCj4+IFNv
IHdlJ3JlIGF0IHRocmVlIHBhdGNoZXM6DQo+Pg0KPj4gICAgLSBkcm9wIEVOT01FTSBtZXNz
YWdlDQo+PiAgICAtIGNvbnZlcnQgZXhpc3RpbmcgbWVzc2FnZXMgdG8gZGV2X2Vycl9wcm9i
ZSgpDQo+PiAgICAtIGludHJvZHVjZSBlcnJvcnMgZm9yIGRldm1fZ3Bpb2RfZ2V0KCkgYW5k
IGRldm1faWlvX2RldmljZV9yZWdpc3RlcigpDQo+Pg0KPj4gSSBjYW4gcmV3b3JrIGFjY29y
ZGluZ2x5LCBidXQgZm9yIG1lIHRoaXMgbG9va3MgYSBiaXQgb3ZlciBlbmdpbmVlcmVkLg0K
PiANCj4gUGVyaGFwcywgYnV0IHRoZXkgdGhyZWUgYXJlIGFib3V0IGRpZmZlcmVudCBzdHVm
Zi4NCg0KVGhlIGRpZmZlcmVudCB0aGluZ3MgY291bGQgYmUgbmFtZWQgYXMgZm9sbG93czoN
Cg0KICAtIEltcHJvdmUgZXJyb3IgcmVwb3J0aW5nIGluIC5wcm9iZSgpIGZvciBkZXZtX2lp
b19kZXZpY2VfYWxsb2MoKQ0KICAtIEltcHJvdmUgZXJyb3IgcmVwb3J0aW5nIGluIC5wcm9i
ZSgpIGZvciBkZXZtX2dwaW9kX2dldCgpDQogIC0gSW1wcm92ZSBlcnJvciByZXBvcnRpbmcg
aW4gLnByb2JlKCkgZm9yIGdwaW9kX3RvX2lycSgpDQogIC0gSW1wcm92ZSBlcnJvciByZXBv
cnRpbmcgaW4gLnByb2JlKCkgZm9yIGRldm1faWlvX2RldmljZV9yZWdpc3RlcigpDQoNCkV2
ZW4gYWZ0ZXIgdGhlIGRpc2N1c3Npb24gSSB0aGluayBpdCdzIG9rIHRvIHN1bW1hcml6ZSB0
aGF0IHRvIGEgc2luZ2xlIA0KcGF0Y2ggIkltcHJvdmUgZXJyb3IgcmVwb3J0aW5nIGluIC5w
cm9iZSgpIi4gSSdkIHdhaXQgZm9yIEpvbmF0aGFuJ3MgDQpmZWVkYmFjayB3aXRoIGhpcyBv
cGluaW9uIGJlZm9yZSByZXdvcmtpbmcgdGhlIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMNClV3
ZQ0K

--------------54hoEkZCKYwK1RvsjLMk6bxg--

--------------01M65Tha302lioebOw0KdBUP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK9r+oACgkQwfwUeK3K
7AlVVQgAmN/8I5eQHof7USXjPhQ/S5LemsNflr+63HOw++VjiaFyN+7sTPgYwu62
zvlHJCOWe8hsiu4dDD0JiyQZHFSZsitIDIzuUwiX320Eik/hzUbx+wdbBt5llItA
BDdby35tYs+yAq/2aFoQjuqPyPZC/7trg5kf3nvDjzTTiSjAsllI+Q2CV/5xDpHo
YPyHKICcHL0d9iUDVp6QNFwzOLicq2VA1PZIRdY9aFhX3zqrdz1KnjtTkpB0gcAt
r9vCUv1TQ6iX/BHelNo2Cggpa0uiCSlcEOZEpigt29gUvaVe7gXi3S+pYpw86hQ/
mlcjDg+OkhbPmdZqaxepxRSlZnVQnQ==
=BFCc
-----END PGP SIGNATURE-----

--------------01M65Tha302lioebOw0KdBUP--
