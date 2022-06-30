Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8C561794
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiF3KVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiF3KVL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 06:21:11 -0400
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 03:21:09 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2F45064
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 03:21:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id D2D43495E51;
        Thu, 30 Jun 2022 12:14:54 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id NwXCAnR12vTv; Thu, 30 Jun 2022 12:14:54 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b694:6cfc:9c6f:9d3e:3e3:5d2d])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu, 30 Jun 2022 12:14:54 +0200 (CEST)
Message-ID: <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
Date:   Thu, 30 Jun 2022 12:14:49 +0200
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
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
In-Reply-To: <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZL8wcAs0SjaV2tkE29P6Raqn"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZL8wcAs0SjaV2tkE29P6Raqn
Content-Type: multipart/mixed; boundary="------------bynxaIDLyI9sspcFJcZulMD2";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio <linux-iio@vger.kernel.org>, Yves-Alexis Perez <corsac@debian.org>
Message-ID: <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
References: <20220630063528.205327-1-ukleinek@debian.org>
 <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
In-Reply-To: <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>

--------------bynxaIDLyI9sspcFJcZulMD2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNi8zMC8yMiAwOToxNywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUaHUsIEp1
biAzMCwgMjAyMiBhdCA4OjU4IEFNIFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0BkZWJp
YW4ub3JnPiB3cm90ZToNCj4+DQo+PiBEb24ndCBlbWl0IGEgbWVzc2FnZSBmb3IgLUVOT01F
TSwgdGhlIGtlcm5lbCBpcyBhbHJlYWR5IGxvdWQgZW5vdWdoIGluDQo+PiB0aGlzIGNhc2Uu
IEFkZCBhIG1lc3NhZ2UgaWYgZ2V0dGluZyB0aGUgR1BJTyBvciByZWdpc3RlcmluZyB0aGUg
aWlvDQo+PiBkZXZpY2UgZmFpbHMgYW5kIHVzZSBkZXZfZXJyX3Byb2JlIGZvciBpbXByb3Zl
ZCBiZWhhdmlvdXIgb24NCj4+IC1FUFJPQkVfREVGRVIuDQo+IA0KPiBXaHkgZG8gd2UgbmVl
ZCBhZGRpdGlvbmFsIG1lc3NhZ2VzPw0KDQpJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHF1ZXN0
aW9uLiBEbyB5b3UgcmVhbGx5IHdvbmRlciB3aHkgdGhlcmUgaXMgYSANCmJlbmVmaXQgb2Yg
YW4gZXJyb3IgbWVzc2FnZSBpZiBhIHJlc291cmNlIGFsbG9jYXRpb24gaW4gcHJvYmUgZmFp
bHM/DQoNCkN1cnJlbnQgc3RhdGUgaXMgdGhhdCBmb3IgWXZlcy1BbGV4aXMgKG9uIENjOikg
dGhlIGRyaXZlciBpcyBzaWxlbnQgYnV0IA0KdW5ib3VuZC4gSSBndWVzcyB0aGF0J3MgYmVj
YXVzZSBncGlvZF9nZXQgZmFpbHMsIGJ1dCBzZWVpbmcgYSANCmNvbmZpcm1hdGlvbiBpbiB0
aGUga2VybmVsIGxvZyB3b3VsZCBiZSBuaWNlLg0KDQo+IFRoZXkgc2hvdWxkIGJlIHNwbGl0
IGluIGEgc2VwYXJhdGUgcGF0Y2gsIHBlcmhhcHMsIHdpdGggdGhlIGV4cGxhbmF0aW9uLg0K
PiANCj4gQWN0dWFsbHkgdGhlIHJlc3QgSSB3b3VsZCBzcGxpdCB0byB0d286IGNvbnZlcnRp
bmcgdG8gZGV2X2Vycl9wcm9iZSgpDQo+IGluIHRoZSBjYXNlIHdoZXJlIGl0J3Mgbm90IHJp
Z2h0IG5vdywgYW5kIGRyb3BwaW5nIEVOT01FTSBtZXNzYWdlLg0KDQpTbyB3ZSdyZSBhdCB0
aHJlZSBwYXRjaGVzOg0KDQogIC0gZHJvcCBFTk9NRU0gbWVzc2FnZQ0KICAtIGNvbnZlcnQg
ZXhpc3RpbmcgbWVzc2FnZXMgdG8gZGV2X2Vycl9wcm9iZSgpDQogIC0gaW50cm9kdWNlIGVy
cm9ycyBmb3IgZGV2bV9ncGlvZF9nZXQoKSBhbmQgZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVy
KCkNCg0KSSBjYW4gcmV3b3JrIGFjY29yZGluZ2x5LCBidXQgZm9yIG1lIHRoaXMgbG9va3Mg
YSBiaXQgb3ZlciBlbmdpbmVlcmVkLg0KDQpCZXN0IHJlZ2FyZHMNClV3ZQ0K

--------------bynxaIDLyI9sspcFJcZulMD2--

--------------ZL8wcAs0SjaV2tkE29P6Raqn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK9d5kACgkQwfwUeK3K
7AlGGgf/WZ0HNpjfpeN7VGiCyuqckzkloeoMmXeZznXQE/fq9ACybw4oy5hDG10S
hzW98y+ti6/uSQ68ddOF3eFUV20en8VCIgMkpXc1xvK8HkVvEg7vBZ07MStp1UVN
MQFBt6I3bRLI8jfaPA52MjC8D/VHszpwFHgGAJIoXb6RdvRFcmaA1qB87gaRVwIu
k9n8zPbFArfClQZA8BODaLCCUHBNiMaj7am2EgHwKZx4PalrbDbmCXoSYcTHIy7l
LrEc1RSwJlGapuVuP/deHhmo7L9no7RpuVC7hRknmqVUh9kzcvrnY398vSGhvgCt
7IEWfeaBLEm83+bhFvUgWjp8hjFYnA==
=+F0j
-----END PGP SIGNATURE-----

--------------ZL8wcAs0SjaV2tkE29P6Raqn--
