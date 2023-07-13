Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F975192F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jul 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjGMG5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Jul 2023 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjGMG5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jul 2023 02:57:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7068AE8;
        Wed, 12 Jul 2023 23:57:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so389279a12.0;
        Wed, 12 Jul 2023 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689231456; x=1691823456;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0Cu6wOVuADONtAPvQmiqYxJ0e3AOe0pW9cW4IcRFN8=;
        b=iunDmPH6GoCzlrD51lxvdp/vNKqJkvgD1eEwHo1wVLdbpB5G1kBdgeZst2YaWHFatK
         rTPTJus8l3bl626t/DG5aLQxmxeqZl0Y4Dsye6/eqaMTjjw5Tzzh6Bdj4rtjtPIhoVW5
         +w3sJDr3HlD3CZjJA9Y2mGyQ/7KeCY1hxlI6xgg5Su7ZpYNu7Kt2hpGZ4IztKj4jv2/L
         kZRne/la+nhw268v4Gz9gwUWUDunoBDCjtOBFjp7UJqM96EPKgKnemZeo+hOAY3kIKO9
         Jni04Ic/szhv0E9/9aa2iEHZHY/un4hIpQUz1q+ZdjoED/NS2k9rv9LMtdL0mCh1KNrt
         CNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231456; x=1691823456;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0Cu6wOVuADONtAPvQmiqYxJ0e3AOe0pW9cW4IcRFN8=;
        b=G9rFuThz+Md5AFzHncjhHwuerQNNr6l0GIt5k1R5bpgg5z8rvAFomwyTW8+FBAMUDc
         T0cvmmS6olOvgNO/rPQ7dhQwaZPi3FR+J+nyqO0VVr/JYcMbXdAjZK5mPBSCrvbKmQac
         +FCJDsWsgVc+bxQE99Qt/KCAmcFniPDa0Ohd2DUsSWT2YL5HZAbO61raANxFex0phiM9
         S608b7PYWDiXvF/8o1VzYuL1atKgXDGvvZvyDnLeK7U8d3691j8u451nIuhSazyDwb47
         ulq/YBrf6bk0poiMbFnZCqp7ncvCUjcyaKHfgOpBoVRXFaOk1Aob6vCoAA3kBO5OPnKw
         I19w==
X-Gm-Message-State: ABy/qLawV75oY/eO05pXQhkCRpy1Izzdt6DmdSrUjJ+G1Kzh/JqwJd2K
        VlEb/T1h5h1zJ+8ImH5vw1Q=
X-Google-Smtp-Source: APBJJlFJg4saOX0v+2i3gz9poSpDqo0x+SZtbXhIGH2/uf44JbuyjBIwD7WRKr9bF5ebriR4wf+l3A==
X-Received: by 2002:a05:6402:616:b0:51e:c61:1cd6 with SMTP id n22-20020a056402061600b0051e0c611cd6mr748528edv.35.1689231455611;
        Wed, 12 Jul 2023 23:57:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id be25-20020a0564021a3900b00514a5f7a145sm3825194edb.37.2023.07.12.23.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:57:35 -0700 (PDT)
Message-ID: <a88df73e0abda8da0a4af82a6ae5b79083bcc14b.camel@gmail.com>
Subject: Re: [PATCH 1/1] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 08:57:34 +0200
In-Reply-To: <20230712075054.953421-2-ramona.bolboaca@analog.com>
References: <20230712075054.953421-1-ramona.bolboaca@analog.com>
         <20230712075054.953421-2-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDEwOjUwICswMzAwLCBSYW1vbmEgQm9sYm9hY2Egd3JvdGU6
Cj4gQWRkIGRlbHRhIGFuZ2xlIGFuZCBkZWx0YSB2ZWxvY2l0eSBjaGFubmVscyB0byBhZGlzMTY0
NzUgZHJpdmVyLgo+IEFsbCBzdXBwb3J0ZWQgZGV2aWNlcyBvZmZlciB0aGUgY2FwYWJpbGl0aWVz
IHRvIHJlYWQgdGhpcyBkYXRhCj4gYnkgcGVyZm9ybWluZyByYXcgcmVnaXN0ZXIgcmVhZHMuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogUmFtb25hIEJvbGJvYWNhIDxyYW1vbmEuYm9sYm9hY2FAYW5hbG9n
LmNvbT4KPiAtLS0KClRvIG5vdGUgdGhhdCBmb3Igc29tZSBkZXZpY2VzIChsaWtlIGFkaXMxNTA1
KSB0aGVzZSBjaGFubmVscyBjYW4gYWxzbyBiZSBidWZmZXJlZAoobm90IHRvZ2V0aGVyIHdpdGgg
bm9ybWFsIGFjY2VsIGFuZCBneXJvIGRhdGEpIHNvIHdlIHNob3VsZCBzdXBwb3J0IGl0IGFzIHdl
IGhhdmUKZXZlcnl0aGluZyBuZWVkZWQuIEkgaG9uZXN0bHkgdGhpbmsgaXQgc2hvdWxkIGJlIGRv
bmUgcmlnaHQgbm93IGJ1dCBpdCB3b3VsZCBiZSBhCm1vcmUgY29tcGxleCBjaGFuZ2UsIHllcy4g
QW55d2F5cywgSSBkb24ndCBmZWVsIHRvbyBzdHJvbmcgYWJvdXQgaXQsIHNvOgoKUmV2aWV3ZWQt
Ynk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4KCihBQkkgcmVsYXRlZCwgd2UncmUgYWxz
byBub3QgY29tcGxldGVseSBzdXJlIElJT19ST1QgaXMgYSBwZXJmZWN0IGZpdCBidXQgaG9wZWZ1
bGx5Cmdvb2QgZW5vdWdoKS4KCj4gwqBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgfCA4OCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwg
ODggaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2
NDc1LmMgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMKPiBpbmRleCAzYWJmZmIwMWJhMzEu
Ljg0YmVlOWUxNTViZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMK
PiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMKPiBAQCAtMzEsNiArMzEsMTIgQEAK
PiDCoCNkZWZpbmUgQURJUzE2NDc1X1JFR19ZX0FDQ0VMX0zCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDB4MTQKPiDCoCNkZWZpbmUgQURJUzE2NDc1X1JFR19aX0FDQ0VMX0zCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MTgKPiDCoCNkZWZpbmUgQURJUzE2NDc1X1JFR19U
RU1QX09VVMKgwqDCoMKgwqDCoMKgwqDCoDB4MWMKPiArI2RlZmluZSBBRElTMTY0NzVfUkVHX1hf
REVMVEFOR19MwqDCoMKgwqDCoMKgMHgyNAo+ICsjZGVmaW5lIEFESVMxNjQ3NV9SRUdfWV9ERUxU
QU5HX0zCoMKgwqDCoMKgwqAweDI4Cj4gKyNkZWZpbmUgQURJUzE2NDc1X1JFR19aX0RFTFRBTkdf
TMKgwqDCoMKgwqDCoDB4MkMKPiArI2RlZmluZSBBRElTMTY0NzVfUkVHX1hfREVMVFZFTF9MwqDC
oMKgwqDCoMKgMHgzMAo+ICsjZGVmaW5lIEFESVMxNjQ3NV9SRUdfWV9ERUxUVkVMX0zCoMKgwqDC
oMKgwqAweDM0Cj4gKyNkZWZpbmUgQURJUzE2NDc1X1JFR19aX0RFTFRWRUxfTMKgwqDCoMKgwqDC
oDB4MzgKPiDCoCNkZWZpbmUgQURJUzE2NDc1X1JFR19YX0dZUk9fQklBU19MwqDCoMKgwqAweDQw
Cj4gwqAjZGVmaW5lIEFESVMxNjQ3NV9SRUdfWV9HWVJPX0JJQVNfTMKgwqDCoMKgMHg0NAo+IMKg
I2RlZmluZSBBRElTMTY0NzVfUkVHX1pfR1lST19CSUFTX0zCoMKgwqDCoDB4NDgKPiBAQCAtOTAs
NiArOTYsOCBAQCBzdHJ1Y3QgYWRpczE2NDc1X2NoaXBfaW5mbyB7Cj4gwqDCoMKgwqDCoMKgwqDC
oHUzMiBhY2NlbF9tYXhfdmFsOwo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgYWNjZWxfbWF4X3NjYWxl
Owo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgdGVtcF9zY2FsZTsKPiArwqDCoMKgwqDCoMKgwqB1MzIg
ZGVsdGFuZ19tYXhfdmFsOwo+ICvCoMKgwqDCoMKgwqDCoHUzMiBkZWx0dmVsX21heF92YWw7Cj4g
wqDCoMKgwqDCoMKgwqDCoHUzMiBpbnRfY2xrOwo+IMKgwqDCoMKgwqDCoMKgwqB1MTYgbWF4X2Rl
YzsKPiDCoMKgwqDCoMKgwqDCoMKgdTggbnVtX3N5bmM7Cj4gQEAgLTQ1Myw2ICs0NjEsMTQgQEAg
c3RhdGljIGludCBhZGlzMTY0NzVfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgSUlPX1RFTVA6Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnZhbCA9IHN0LT5pbmZv
LT50ZW1wX3NjYWxlOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBJSU9fVkFMX0lOVDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY2FzZSBJSU9fUk9UOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKnZhbCA9IHN0LT5pbmZvLT5kZWx0YW5nX21heF92YWw7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqdmFsMiA9IDMxOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIElJT19WQUxfRlJB
Q1RJT05BTF9MT0cyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIElJT19W
RUxPQ0lUWToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCp2YWwgPSBzdC0+aW5mby0+ZGVsdHZlbF9tYXhfdmFsOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnZhbDIgPSAzMTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUxf
TE9HMjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gQEAgLTU1Myw2ICs1NjksMzIg
QEAgc3RhdGljIGludCBhZGlzMTY0NzVfd3JpdGVfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9LCBcCj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoAo+ICsjZGVmaW5lIEFESVMxNjQ3NV9NT0RfQ0hBTl9ERUxUQShfdHlwZSwgX21v
ZCwgX2FkZHJlc3MsIF9yX2JpdHMsIF9zX2JpdHMpIHsgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAudHlwZSA9IChfdHlwZSksIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLm1vZGlmaWVkID0gMSwgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
Y2hhbm5lbDIgPSAoX21vZCksIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmlu
Zm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVyksIFwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLmluZm9fbWFza19zaGFyZWRfYnlfdHlwZSA9IEJJVChJSU9f
Q0hBTl9JTkZPX1NDQUxFKSwgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW5m
b19tYXNrX3NoYXJlZF9ieV9hbGwgPSBCSVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpIHwgXAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQklUKElJT19D
SEFOX0lORk9fTE9XX1BBU1NfRklMVEVSXzNEQl9GUkVRVUVOQ1kpLCBcCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5hZGRyZXNzID0gKF9hZGRyZXNzKSwgXAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAuc2Nhbl9pbmRleCA9IC0xLCBcCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5zY2FuX3R5cGUgPSB7IFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zaWduID0gJ3MnLCBcCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucmVhbGJpdHMgPSAoX3JfYml0cyksIFwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zdG9yYWdl
Yml0cyA9IChfc19iaXRzKSwgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLmVuZGlhbm5lc3MgPSBJSU9fQkUsIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfSwgXAo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gKyNkZWZpbmUgQURJUzE2
NDc1X0RFTFRBTkdfQ0hBTihfbW9kKSBcCj4gK8KgwqDCoMKgwqDCoMKgQURJUzE2NDc1X01PRF9D
SEFOX0RFTFRBKElJT19ST1QsIElJT19NT0RfICMjIF9tb2QsIFwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQURJUzE2NDc1X1JFR18gIyMgX21v
ZCAjIyBfREVMVEFOR19MLCAzMiwgMzIpCj4gKwo+ICsjZGVmaW5lIEFESVMxNjQ3NV9ERUxUVkVM
X0NIQU4oX21vZCkgXAo+ICvCoMKgwqDCoMKgwqDCoEFESVMxNjQ3NV9NT0RfQ0hBTl9ERUxUQShJ
SU9fVkVMT0NJVFksIElJT19NT0RfICMjIF9tb2QsIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQURJUzE2NDc1X1JFR18gIyMgX21vZCAjIyBf
REVMVFZFTF9MLCAzMiwgMzIpCj4gKwo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9z
cGVjIGFkaXMxNjQ3NV9jaGFubmVsc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqBBRElTMTY0NzVf
R1lST19DSEFOTkVMKFgpLAo+IMKgwqDCoMKgwqDCoMKgwqBBRElTMTY0NzVfR1lST19DSEFOTkVM
KFkpLAo+IEBAIC01NjEsNiArNjAzLDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyBhZGlzMTY0NzVfY2hhbm5lbHNbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgQURJUzE2NDc1
X0FDQ0VMX0NIQU5ORUwoWSksCj4gwqDCoMKgwqDCoMKgwqDCoEFESVMxNjQ3NV9BQ0NFTF9DSEFO
TkVMKFopLAo+IMKgwqDCoMKgwqDCoMKgwqBBRElTMTY0NzVfVEVNUF9DSEFOTkVMKCksCj4gK8Kg
wqDCoMKgwqDCoMKgQURJUzE2NDc1X0RFTFRBTkdfQ0hBTihYKSwKPiArwqDCoMKgwqDCoMKgwqBB
RElTMTY0NzVfREVMVEFOR19DSEFOKFkpLAo+ICvCoMKgwqDCoMKgwqDCoEFESVMxNjQ3NV9ERUxU
QU5HX0NIQU4oWiksCj4gK8KgwqDCoMKgwqDCoMKgQURJUzE2NDc1X0RFTFRWRUxfQ0hBTihYKSwK
PiArwqDCoMKgwqDCoMKgwqBBRElTMTY0NzVfREVMVFZFTF9DSEFOKFkpLAo+ICvCoMKgwqDCoMKg
wqDCoEFESVMxNjQ3NV9ERUxUVkVMX0NIQU4oWiksCj4gwqDCoMKgwqDCoMKgwqDCoElJT19DSEFO
X1NPRlRfVElNRVNUQU1QKDcpCj4gwqB9Owo+IMKgCj4gQEAgLTY2NCw2ICs3MTIsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRpczE2NDc1X2NoaXBfaW5mb1td
ID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3ZhbCA9
IDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3NjYWxlID0g
SUlPX01fU18yX1RPX0coODAwIDw8IDE2KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC50ZW1wX3NjYWxlID0gMTAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
ZGVsdGFuZ19tYXhfdmFsID0gMjE2MCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LmRlbHR2ZWxfbWF4X3ZhbCA9IDQwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5pbnRfY2xrID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhf
ZGVjID0gMTk5OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRp
czE2NDc1X3N5bmNfbW9kZSwKPiBAQCAtNjc5LDYgKzcyOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYWRpczE2NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+IHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gMSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUgPSBJSU9fTV9TXzJfVE9f
Ryg0MDAwIDw8IDE2KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC50ZW1wX3Nj
YWxlID0gMTAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdGFuZ19tYXhf
dmFsID0gMzYwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdHZlbF9tYXhf
dmFsID0gMTAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmludF9jbGsgPSAy
MDAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF9kZWMgPSAxOTk5LAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnN5bmMgPSBhZGlzMTY0NzVfc3luY19t
b2RlLAo+IEBAIC02OTQsNiArNzQ2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzMTY0NzVf
Y2hpcF9pbmZvIGFkaXMxNjQ3NV9jaGlwX2luZm9bXSA9Cj4gewo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLmFjY2VsX21heF92YWwgPSAxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLmFjY2VsX21heF9zY2FsZSA9IElJT19NX1NfMl9UT19HKDQwMDAgPDwgMTYp
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnRlbXBfc2NhbGUgPSAxMDAsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0YW5nX21heF92YWwgPSA3MjAsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwgPSAxMDAsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUsCj4gQEAgLTcw
OSw2ICs3NjMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRp
czE2NDc1X2NoaXBfaW5mb1tdID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuYWNjZWxfbWF4X3ZhbCA9IDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
YWNjZWxfbWF4X3NjYWxlID0gSUlPX01fU18yX1RPX0coNDAwMCA8PCAxNiksCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLmRlbHRhbmdfbWF4X3ZhbCA9IDIxNjAsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwgPSAxMDAsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUsCj4gQEAgLTcyNCw2ICs3ODAsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRpczE2NDc1X2NoaXBf
aW5mb1tdID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4
X3ZhbCA9IDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3Nj
YWxlID0gSUlPX01fU18yX1RPX0coODAwIDw8IDE2KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC50ZW1wX3NjYWxlID0gMTAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAuZGVsdGFuZ19tYXhfdmFsID0gMzYwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAuZGVsdHZlbF9tYXhfdmFsID0gNDAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmludF9jbGsgPSAyMDAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Lm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnN5bmMg
PSBhZGlzMTY0NzVfc3luY19tb2RlLAo+IEBAIC03MzksNiArNzk3LDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhZGlzMTY0NzVfY2hpcF9pbmZvIGFkaXMxNjQ3NV9jaGlwX2luZm9bXSA9Cj4gewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFjY2VsX21heF92YWwgPSAxLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFjY2VsX21heF9zY2FsZSA9IElJT19NX1Nf
Ml9UT19HKDgwMCA8PCAxNiksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVt
cF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHRhbmdf
bWF4X3ZhbCA9IDcyMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHR2ZWxf
bWF4X3ZhbCA9IDQwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5pbnRfY2xr
ID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVjID0gMTk5
OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2NDc1X3N5
bmNfbW9kZSwKPiBAQCAtNzU0LDYgKzgxNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2
NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+IHsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gMSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUgPSBJSU9fTV9TXzJfVE9fRyg4MDAgPDwg
MTYpLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnRlbXBfc2NhbGUgPSAxMDAs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0YW5nX21heF92YWwgPSAyMTYw
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdHZlbF9tYXhfdmFsID0gNDAw
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmludF9jbGsgPSAyMDAwLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnN5bmMgPSBhZGlzMTY0NzVfc3luY19tb2RlLAo+IEBA
IC03NjksNiArODMxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzMTY0NzVfY2hpcF9pbmZv
IGFkaXMxNjQ3NV9jaGlwX2luZm9bXSA9Cj4gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmFjY2VsX21heF92YWwgPSAxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLmFjY2VsX21heF9zY2FsZSA9IElJT19NX1NfMl9UT19HKDQwMDAgPDwgMTYpLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnRlbXBfc2NhbGUgPSAxMDAsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0YW5nX21heF92YWwgPSAzNjAsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwgPSAxMDAsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUsCj4gQEAgLTc4NCw2ICs4NDgs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRpczE2NDc1X2No
aXBfaW5mb1tdID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxf
bWF4X3ZhbCA9IDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4
X3NjYWxlID0gSUlPX01fU18yX1RPX0coNDAwMCA8PCAxNiksCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmRlbHRhbmdfbWF4X3ZhbCA9IDcyMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmRlbHR2ZWxfbWF4X3ZhbCA9IDEwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC5pbnRfY2xrID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC5tYXhfZGVjID0gMTk5OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5z
eW5jID0gYWRpczE2NDc1X3N5bmNfbW9kZSwKPiBAQCAtNzk5LDYgKzg2NSw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYWRpczE2NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gMSwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUgPSBJSU9f
TV9TXzJfVE9fRyg0MDAwIDw8IDE2KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC50ZW1wX3NjYWxlID0gMTAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVs
dGFuZ19tYXhfdmFsID0gMjE2MCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRl
bHR2ZWxfbWF4X3ZhbCA9IDEwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5p
bnRfY2xrID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVj
ID0gMTk5OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2
NDc1X3N5bmNfbW9kZSwKPiBAQCAtODE0LDYgKzg4Miw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YWRpczE2NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+IHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gMSwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUgPSBJSU9fTV9TXzJfVE9fRyg4
MDAgPDwgMTYpLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnRlbXBfc2NhbGUg
PSAxMDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0YW5nX21heF92YWwg
PSAzNjAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwg
PSA0MDAsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUs
Cj4gQEAgLTgyOSw2ICs4OTksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlw
X2luZm8gYWRpczE2NDc1X2NoaXBfaW5mb1tdID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAuYWNjZWxfbWF4X3ZhbCA9IDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAuYWNjZWxfbWF4X3NjYWxlID0gSUlPX01fU18yX1RPX0coODAwIDw8IDE2KSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC50ZW1wX3NjYWxlID0gMTAwLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdGFuZ19tYXhfdmFsID0gNzIwLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdHZlbF9tYXhfdmFsID0gNDAwLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmludF9jbGsgPSAyMDAwLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLnN5bmMgPSBhZGlzMTY0NzVfc3luY19tb2RlLAo+IEBAIC04NDQsNiAr
OTE2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzMTY0NzVfY2hpcF9pbmZvIGFkaXMxNjQ3
NV9jaGlwX2luZm9bXSA9Cj4gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFj
Y2VsX21heF92YWwgPSAxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFjY2Vs
X21heF9zY2FsZSA9IElJT19NX1NfMl9UT19HKDgwMCA8PCAxNiksCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLmRlbHRhbmdfbWF4X3ZhbCA9IDIxNjAsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwgPSA0MDAsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUsCj4gQEAgLTg1OSw2ICs5MzMsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRpczE2NDc1X2NoaXBfaW5mb1td
ID0KPiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3ZhbCA9
IDM5MiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUg
PSAzMjAwMCA8PCAxNiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC50ZW1wX3Nj
YWxlID0gMTAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdGFuZ19tYXhf
dmFsID0gMjE2MCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHR2ZWxfbWF4
X3ZhbCA9IDQwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5pbnRfY2xrID0g
MjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVjID0gMTk5OSwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2NDc1X3N5bmNf
bW9kZSwKPiBAQCAtODc2LDYgKzk1Miw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2NDc1
X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+IHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gNzgsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3NjYWxlID0gMzIwMDAgPDwgMTYsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLmRlbHRhbmdfbWF4X3ZhbCA9IDM2MCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLmRlbHR2ZWxfbWF4X3ZhbCA9IDEwMCwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5pbnRfY2xrID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5tYXhfZGVjID0gMTk5OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5zeW5jID0gYWRpczE2NDc1X3N5bmNfbW9kZSwKPiBAQCAtODkzLDYgKzk3MSw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9p
bmZvW10gPQo+IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhf
dmFsID0gNzgsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3Nj
YWxlID0gMzIwMDAgPDwgMTYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVt
cF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHRhbmdf
bWF4X3ZhbCA9IDcyMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHR2ZWxf
bWF4X3ZhbCA9IDEwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5pbnRfY2xr
ID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVjID0gMTk5
OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2NDc1X3N5
bmNfbW9kZSwKPiBAQCAtOTEwLDYgKzk5MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2
NDc1X2NoaXBfaW5mbyBhZGlzMTY0NzVfY2hpcF9pbmZvW10gPQo+IHsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfdmFsID0gNzgsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3NjYWxlID0gMzIwMDAgPDwgMTYsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRlbHRhbmdfbWF4X3ZhbCA9IDIxNjAsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZWx0dmVsX21heF92YWwgPSAxMDAsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW50X2NsayA9IDIwMDAsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21vZGUsCj4gQEAgLTkyNyw2ICsxMDA5
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzMTY0NzVfY2hpcF9pbmZvIGFkaXMxNjQ3NV9j
aGlwX2luZm9bXQo+ID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFjY2Vs
X21heF92YWwgPSAzOTIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxf
bWF4X3NjYWxlID0gMzIwMDAgPDwgMTYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAudGVtcF9zY2FsZSA9IDEwMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRl
bHRhbmdfbWF4X3ZhbCA9IDM2MCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRl
bHR2ZWxfbWF4X3ZhbCA9IDQwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5p
bnRfY2xrID0gMjAwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVj
ID0gMTk5OSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2
NDc1X3N5bmNfbW9kZSwKPiBAQCAtOTQ0LDYgKzEwMjgsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGFkaXMxNjQ3NV9jaGlwX2luZm8gYWRpczE2NDc1X2NoaXBfaW5mb1tdCj4gPSB7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNjZWxfbWF4X3ZhbCA9IDM5MiwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hY2NlbF9tYXhfc2NhbGUgPSAzMjAwMCA8PCAxNiwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC50ZW1wX3NjYWxlID0gMTAwLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdGFuZ19tYXhfdmFsID0gNzIwLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGVsdHZlbF9tYXhfdmFsID0gNDAwLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmludF9jbGsgPSAyMDAwLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLnN5bmMgPSBhZGlzMTY0NzVfc3luY19tb2RlLAo+IEBAIC05NjEs
NiArMTA0Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2NDc1X2NoaXBfaW5mbyBhZGlz
MTY0NzVfY2hpcF9pbmZvW10KPiA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5hY2NlbF9tYXhfdmFsID0gMzkyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LmFjY2VsX21heF9zY2FsZSA9IDMyMDAwIDw8IDE2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLnRlbXBfc2NhbGUgPSAxMDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC5kZWx0YW5nX21heF92YWwgPSAyMTYwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAuZGVsdHZlbF9tYXhfdmFsID0gNDAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmludF9jbGsgPSAyMDAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Lm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnN5bmMg
PSBhZGlzMTY0NzVfc3luY19tb2RlLAoK

