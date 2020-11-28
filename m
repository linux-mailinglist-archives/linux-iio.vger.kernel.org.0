Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7582C7573
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgK1VtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:42797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgK1SBn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606586410;
        bh=llOEp7TKQR/EGzhXDacWl6woOORc2KNFI1XW/Ng1WBE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DJ/nfbKGA6OwjBY2mp6hbCcOIirJNfKNpSO7kJn1PuSzwvcjqecLXZTAjrFoQ1VMx
         CBQMAUjjJXiXKF3bY3ZyVdNQHACYvU2zzn7vKRVKgPzxkX8bfEfxgvnb8aB8XM7Nxm
         cxOX42gAEFQFRlCuQDmnlYVKPTm7T9j3JY7wKJdE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1k1f4F49ag-011S5k; Sat, 28
 Nov 2020 14:45:42 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [RESEND PATCH 2/2] io:core: In iio_map_array_register() cleanup in case of error
Date:   Sat, 28 Nov 2020 14:44:19 +0100
Message-Id: <1606571059-13974-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:42saRdxZ6O4sXs+ITGkakIE0b5eMR+hUo7mlPXHk4FtfBar2KNJ
 TqMXXQOA/UYgWTjPDT8zT05SLCRCfXUBA0s0Ss+thXqER5ZeLG4DYrCx2dkC6truEyGznp6
 vClgHCNLnSe62YVHnDEBZlgxQzg+fCqezVMpOvH+P0hrWkx0KOgsRRPj2NjoDkX7fWAgVC4
 JvqZPRYgT/rzIqCvLbUFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9bbeuahMiQ=:ssS7esfd+e8zblSYq5aV44
 2ckzlX5Ha/IjZ/jI5KpM7aNqIZUNH6ZHhaZt8MjXBT1/ESZ/4t/c8/JJXyz3IWUK300mZE2hV
 OOfieIqXmzyw7xTZwkga4P5HcVEdd40avx2+rc64saYPXVq1kyfZHj1ZPnSMaEwjWpuxefGgy
 aQF3gVLlDRlhtZxIF9Rz2EGKYzpBTj2KfO8yywlmvjAsA7Y9jOmsnOLWnVMKcbPcLYbSf5CXT
 E1ctokGfs1V1QfQujR5u/pnjCpLixXXd+B5jkc4BrTHAVS8031Fb3OpZnbSWiFHY5GM070lMN
 DMu9eCewgtIKMwbWOz7dyq5I8oCqPWFKZWTLEIHZ5UDA9kD/2U6tXQanh9YnWhOmk+H08aTE5
 4JIfK4DVBMNV7WiID8aoa/D93fclGkqgdJs+0m4g/pEwRUpEahptav/wtcaNieI5sgm4qWxkt
 uTeLh+ayDsIgVPkwFl406No678sWPhK9soHnBet71tFukXRDcaUiY4zQuP8RPmg1J3o+0NDpL
 EdYCMUJN2C4HzIZDm4msMJTePFLiER3MXBNnyPkv/wN7gtyEZkKZtxbR8piMoer5bhhujFQVI
 jK2X1quyuqQ3Ip6QdoGMN0aHvbcvtq9ONDJb2fG3uOeo2+tn+jULHQkljy1LWKBvv8Fzkrkq6
 nxUMn3c0zkiOxnFB1/S4OKgYPBL8DelTmcjuHbLO4XOAdym7T7K9k5OVkTevTkofYEvFDOXup
 MiRRH6lhN+EmiS281CmslUEm/fQszY3BiJUt/RxGl21plrxulAHkpUX23GeIZ8JGOzzWDJo6e
 LjwBOP3rfHkoqWqfRnphPaObfHv10y5UrKxbs2vXOhbkvjz4XKLcvgHx0BjVjMKYnjLlJadIP
 F24gpLOFcn4cs6U/C5qg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SW4gZnVuY3Rpb24gaWlvX21hcF9hcnJheV9yZWdpc3RlcigpIHByb3Blcmx5IHJld2luZCBpbiBj
YXNlIG9mIGVycm9yLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmls
aXBwb0BnbXguZGU+ClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5r
b0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9paW8vaW5rZXJuLmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5rZXJuLmMg
Yi9kcml2ZXJzL2lpby9pbmtlcm4uYwppbmRleCAzOWMxZDYzLi5mZTMwYmNiIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2lpby9pbmtlcm4uYworKysgYi9kcml2ZXJzL2lpby9pbmtlcm4uYwpAQCAtNjAs
NiArNjAsOCBAQCBpbnQgaWlvX21hcF9hcnJheV9yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2LCBzdHJ1Y3QgaWlvX21hcCAqbWFwcykKIAkJaSsrOwogCX0KIGVycm9yX3JldDoKKwlp
ZiAocmV0KQorCQlpaW9fbWFwX2FycmF5X3VucmVnaXN0ZXJfbG9ja2VkKGluZGlvX2Rldik7CiAJ
bXV0ZXhfdW5sb2NrKCZpaW9fbWFwX2xpc3RfbG9jayk7CiAKIAlyZXR1cm4gcmV0OwotLSAKMi43
LjQKCg==
