Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9275D2C7571
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgK1VtV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:57285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbgK1SBp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606586412;
        bh=1y7lQ6mSJVuP8bFeEYcO3sN//QRu8cVbO6D2sNz3OR8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ow7GReK3SAD68BTZPww+4Fy5UizfF4vatLipUqJK6tfnNeQlRTelXxXfQHpp77i+Z
         iP6MgvKlCNvPO5Kx/4pElmztszhg6v5kH+rdqk1aswYPfrra8v7vLP6eA/MHNIibPD
         h+oDaZYxdc2ykuKUAvggm0Hgp0CfxQ46I1q1HFh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1kx3342rYt-00F8pB; Sat, 28
 Nov 2020 14:45:41 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [RESEND PATCH 1/2] iio:core: Introduce unlocked version of iio_map_array_unregister()
Date:   Sat, 28 Nov 2020 14:44:18 +0100
Message-Id: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:P0trFNXk9UyPd/J1BiqVcQVNknly/UXlIok3ZG/YBgn2HtVNVts
 OTLM/t2VRlvxleKg0rsY3Tx9l5dlJoGsac7I+SRSIV3qj+OrDkUcB6Z1w1t98K7Zdt2/fXU
 mo2cattR8eCwhYTeGlaXirMuP8DBCRKW0nQqB4BtQ2Ny051Re6/C898t7Jz0KNRl0JMo+rG
 P9ubrfM4Zab6EOqCXinbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJzd9RfOtuk=:oBgS3sH7lCeQC1E0e+15KS
 EDJf5mtjNZHAuIXKvtS5Lfk6MN5nJC4KOlDHxfhghTQYp02zKgplR8knUF9qHoAHGa+rrdk4x
 Jz/k3cv4JRYeaAd8SsoBW0ky+aeUEzlRNVBWKpplY71ICf3KsliukN7TCyiMMzp0/M/LfjSXt
 8ZU1+a0YH0UN2d6dc+FlTMJvLzPkMaWZdzlIBuxRNuNlYH0NJyqjkzDVp5NZTDZJBPaWkGtHa
 qUSb1MZhDdZ7hHFqprZ9BTJT8A44dZiVXqGexukLtrSD2ydHwtzsT+xSsdQAOVPlKFF0lPnUs
 f0xo8has0CqoP5yHB6D5+GeiiD8OGrVLQZoSWhxdj5MO8T5rPIFyfUWFPahJq8Q+7JTJCXNza
 myXpfoX16+GTx+TUEeJcDHl2PK12niwQk8A0P7ZF2wgln2O1XJfwVYTQwABehAOR/LMPt2iWZ
 5PYnPL5r9BigVGaYGwJZoMC6y+jJ2/2a+a6hxhQMvUMMGvcGpT/oc7nhhWboELlRr0PN3cT7K
 3BevCW60UkdhX/s/X8McWaSzSGrFIGAx1/hKyYCuyXp/+g/3zwKC2tc+TiX2z6Kl+yP+W1TGJ
 ii+oNPy1H0kMJJtxBo17bIDYkIni7jWwA2KjBos2CYJdmFV2Zrwotvokg67zz08n8oGz3zdLI
 TpUkWHAGfPxS6VENRYWWqNbwaDYnp/lBmx3FCS8knsVi3MNe3Y9XBv5DjfT3g4EIurKsRxlAu
 EKTHw4+GtWGPB03E/I/c3M2MHrK3GYcFuilJwEWAFpoGwCs5vh60j+RT1zH8SBnz8hOfdQnO9
 0VxQU1VuCI420XiSEe4q8laYQFZktAhzRQzdHllbLyzc1N3FkVK66nQ2ktv1+P4Iv1qSAdp7h
 6na7CAptcklfs1HQl0Ag==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SW50cm9kdWNlIGFuIHVubG9ja2VkIHZlcnNpb24gb2YgaWlvX21hcF9hcnJheV91bnJlZ2lzdGVy
KCkuIFRoaXMgZnVuY3Rpb24KY2FuIGhlbHAgdG8gdW53aW5kIGluIGNhc2Ugb2YgZXJyb3Igd2hp
bGUgdGhlIGlpb19tYXBfbGlzdF9sb2NrIG11dGV4IGlzCmhlbGQuCgpTaWduZWQtb2ZmLWJ5OiBM
aW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KUmV2aWV3ZWQtYnk6IEFuZHkg
U2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2lpby9p
bmtlcm4uYyB8IDI3ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vaW5rZXJuLmMgYi9kcml2ZXJzL2lpby9pbmtlcm4uYwppbmRleCBlZGU5OWUwLi4zOWMxZDYz
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbmtlcm4uYworKysgYi9kcml2ZXJzL2lpby9pbmtl
cm4uYwpAQCAtMjQsNiArMjQsMjEgQEAgc3RydWN0IGlpb19tYXBfaW50ZXJuYWwgewogc3RhdGlj
IExJU1RfSEVBRChpaW9fbWFwX2xpc3QpOwogc3RhdGljIERFRklORV9NVVRFWChpaW9fbWFwX2xp
c3RfbG9jayk7CiAKK3N0YXRpYyBpbnQgaWlvX21hcF9hcnJheV91bnJlZ2lzdGVyX2xvY2tlZChz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQoreworCWludCByZXQgPSAtRU5PREVWOworCXN0cnVj
dCBpaW9fbWFwX2ludGVybmFsICptYXBpLCAqbmV4dDsKKworCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZShtYXBpLCBuZXh0LCAmaWlvX21hcF9saXN0LCBsKSB7CisJCWlmIChpbmRpb19kZXYgPT0g
bWFwaS0+aW5kaW9fZGV2KSB7CisJCQlsaXN0X2RlbCgmbWFwaS0+bCk7CisJCQlrZnJlZShtYXBp
KTsKKwkJCXJldCA9IDA7CisJCX0KKwl9CisJcmV0dXJuIHJldDsKK30KKwogaW50IGlpb19tYXBf
YXJyYXlfcmVnaXN0ZXIoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldiwgc3RydWN0IGlpb19tYXAg
Km1hcHMpCiB7CiAJaW50IGkgPSAwLCByZXQgPSAwOwpAQCAtNTcsMTggKzcyLDEyIEBAIEVYUE9S
VF9TWU1CT0xfR1BMKGlpb19tYXBfYXJyYXlfcmVnaXN0ZXIpOwogICovCiBpbnQgaWlvX21hcF9h
cnJheV91bnJlZ2lzdGVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpCiB7Ci0JaW50IHJldCA9
IC1FTk9ERVY7Ci0Jc3RydWN0IGlpb19tYXBfaW50ZXJuYWwgKm1hcGksICpuZXh0OworCWludCBy
ZXQ7CiAKIAltdXRleF9sb2NrKCZpaW9fbWFwX2xpc3RfbG9jayk7Ci0JbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKG1hcGksIG5leHQsICZpaW9fbWFwX2xpc3QsIGwpIHsKLQkJaWYgKGluZGlvX2Rl
diA9PSBtYXBpLT5pbmRpb19kZXYpIHsKLQkJCWxpc3RfZGVsKCZtYXBpLT5sKTsKLQkJCWtmcmVl
KG1hcGkpOwotCQkJcmV0ID0gMDsKLQkJfQotCX0KKwlyZXQgPSBpaW9fbWFwX2FycmF5X3VucmVn
aXN0ZXJfbG9ja2VkKGluZGlvX2Rldik7CiAJbXV0ZXhfdW5sb2NrKCZpaW9fbWFwX2xpc3RfbG9j
ayk7CisKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTF9HUEwoaWlvX21hcF9hcnJheV91
bnJlZ2lzdGVyKTsKLS0gCjIuNy40Cgo=
