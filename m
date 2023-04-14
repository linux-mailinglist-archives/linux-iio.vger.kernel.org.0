Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680D16E1C19
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 07:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNF57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 01:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDNF56 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 01:57:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47574EEA
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 22:57:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v27so7111600wra.13
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681451875; x=1684043875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMBVJUEaCUJxsQe7470VuSd5KnE5w41w61q4gOPODEE=;
        b=VBOUKQcqyjAgfRJ7y3dOm2AM/xLZtd1NUZWSynQJDKm3tu3vfatjeBUh2CTgYEBd54
         WdAWtFwU0zMK4+buW7UjoQsrlYKvuhNaCJnFmCFC1BkxDSaZjgZ9zJ6ZHIxFGH9+TCbQ
         NLd9oGxzOY1klk1BIs9Ih8kOl1ObI4aYRU+l4fy5L7t01kwdqxmOx4feiHd1BO3xNoDT
         rW10KqRrv1rfh+AgfB5802nA8a3lJmGHGuCAxBA+E228J56uhSuvDW8OG5awnR+02PfK
         DumcN4eB99JmbmiUrb89fm3LUtcK2Yw53zxVNZASHhVmW19Iz/thEw5CIAPdeGaGPXRW
         iRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681451875; x=1684043875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMBVJUEaCUJxsQe7470VuSd5KnE5w41w61q4gOPODEE=;
        b=G4NI9p/7dTrGcP9sO3yCrUuGW1SMChDYCSmUbpHLC26qilt7P5TAriapUUJPKFfxxV
         z7fIN5uWYZZA4O2AA1+L2a1hKyNiapVLbNtUXTdAsHATu1c/yHq7f1BPnHLrz4dAZijr
         YZ4M9v3vb9etT255m67kidGaC8r/+GpCFnpHSge0TlthERyqRfiKeXQ4L7Qdev39opqE
         4oATBfzv7I5GOgazTImWVCYRx+8rl2S9R6iWlt/rIrSMkcS2K7fylVrotiyissSiCtlq
         489koZz2FtP84OBu4wrdbC+Lo777u0kVFRkLrHn5qheidiTCVElnkViWF6s5dUotvvHC
         aLQg==
X-Gm-Message-State: AAQBX9fJ3XfskYGQC33yAhQXPgrU/D5ZPWHtEyDY5Y+d7gOBJ+Rcj2B1
        N7WmOnIvpG16YM4Qo0+iw2Ym1Sw9NzNulWJs
X-Google-Smtp-Source: AKy350ZJYC04gn9AU568/GK6h/WH20b+PmlWMn9LU4JK7w1ExuRx06m4rVfOnl0K6PG5Uw5iGyKTYA==
X-Received: by 2002:adf:eb45:0:b0:2f2:a08e:8a00 with SMTP id u5-20020adfeb45000000b002f2a08e8a00mr3082750wrn.17.1681451875047;
        Thu, 13 Apr 2023 22:57:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:134d:a001:f2d9:b7d:7ae:9db3? ([2001:a61:134d:a001:f2d9:b7d:7ae:9db3])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b002efb6e0c495sm2734449wrn.91.2023.04.13.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 22:57:54 -0700 (PDT)
Message-ID: <ce69fcd4ed928cf5cb47847235826668e9b61beb.camel@gmail.com>
Subject: Re: [PATCH] iio: tmag5273: Fix runtime PM leak on measurement error
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org
Date:   Fri, 14 Apr 2023 07:57:54 +0200
In-Reply-To: <20230414013752.498767-1-lars@metafoo.de>
References: <20230414013752.498767-1-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDE4OjM3IC0wNzAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6Cj4gVGhlIHRtYWc1MjczIGdldHMgYSBydW50aW1lIFBNIHJlZmVyZW5jZSBiZWZvcmUgcmVh
ZGluZyBhIG1lYXN1cmVtZW50Cj4gYW5kCj4gcmVsZWFzZXMgaXQgd2hlbiBkb25lLiBCdXQgaWYg
dGhlIG1lYXN1cmVtZW50IGZhaWxzIHRoZQo+IHRtYWc1MjczX3JlYWRfcmF3KCkKPiBmdW5jdGlv
biBleGl0cyBiZWZvcmUgcmVsZWFzaW5nIHRoZSByZWZlcmVuY2UuCj4gCj4gTWFrZSBzdXJlIHRo
YXQgdGhpcyBlcnJvciBwYXRoIGFsc28gcmVsZWFzZXMgdGhlIHJ1bnRpbWUgUE0KPiByZWZlcmVu
Y2UuCj4gCj4gRml4ZXM6IDg2NmExMzg5MTc0YiAoImlpbzogbWFnbmV0b21ldGVyOiBhZGQgdGkg
dG1hZzUyNzMgZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4gPGxh
cnNAbWV0YWZvby5kZT4KPiAtLS0KClJldmlld2VkLWJ5OiBOdW5vIFNhIDxudW5vLnNhQGFuYWxv
Zy5jb20+Cgo+IMKgZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL3RtYWc1MjczLmMgfCA1ICsrKy0t
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvdG1hZzUyNzMuYwo+IGIvZHJp
dmVycy9paW8vbWFnbmV0b21ldGVyL3RtYWc1MjczLmMKPiBpbmRleCAyOGJiN2VmZThkZjguLmUx
NTVhNzViM2NkMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvdG1hZzUy
NzMuYwo+ICsrKyBiL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci90bWFnNTI3My5jCj4gQEAgLTI5
NiwxMiArMjk2LDEzIEBAIHN0YXRpYyBpbnQgdG1hZzUyNzNfcmVhZF9yYXcoc3RydWN0IGlpb19k
ZXYKPiAqaW5kaW9fZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldCA9IHRtYWc1MjczX2dldF9tZWFzdXJlKGRhdGEsICZ0LCAmeCwgJnksICZ6LAo+ICZh
bmdsZSwgJm1hZ25pdHVkZSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbV9ydW50aW1l
X21hcmtfbGFzdF9idXN5KGRhdGEtPmRldik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChkYXRhLT5kZXYpOwo+IMKgCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAoY2hhbi0+YWRkcmVzcykgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSBURU1QRVJBVFVSRToKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqdmFsID0gdDsKCg==

