Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACCD291534
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 03:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440075AbgJRBOb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 21:14:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:46929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440072AbgJRBOb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Oct 2020 21:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602983623;
        bh=1OPnAzyG0UP63YieKjebVmqLGBRWiUnIlrUbQC4b4Xg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A/bUyM/LQa6AqyW4GxjLeyB4LirSd5cIw6RZLhNlaDTULPu/mt7IrGxq7bbPsDilD
         QwdZ3GPn7P0ymQ041i5mC9Z+3nYD7KAVPd2qGrXEP8oTKBz8Ve53Kizhd+ImU+KOAB
         fXvH2MtYW/PFs63JHFsdN0Zh4Gyn265AEK7drsHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1kehqw2w1Z-00Fl7i; Sun, 18
 Oct 2020 03:13:43 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     andy.shevchenko@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:core: In map_array_register() cleanup in case of error 
Date:   Sun, 18 Oct 2020 03:11:54 +0200
Message-Id: <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
References: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UT979+DTW55HwB8+y4JN2u4i/kCPkrgJHnUCbza1Hg0hcGzVGYK
 BA0kVXAmkPpaUnpjeA7YdcspdCNDHn44cvi0siuRedFAIr/bvAIBYbuscsmKkEo5KsSxtj2
 lOXbU1MKlpWJ2kAl8tdJ99CPn7tv9nz4c84UMSGRS5XTeyEpe4LPD5SkrlcN2iHeKm6yulQ
 /AhbnFHgoMYinBLqpSa7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQp0Y63Rfgs=:+gOJBqOilWlqdqFI4z+fa+
 4KMF4F4wkdJTHrLdnWPTQQv9e1WL0gNmAIqEJi4XRgHxIlf9mmXjw4FDnj00jpSGa29ZwYenE
 hCJuoiXJcNXbh65EIQO361a5Pw0TyJp+kmGNtUZeGXVYIADIaPQPBiGHYcO5Ev65ZxJeqpfaf
 iW0y4r7OqmL52KBzBaiVh+Kh7BM6nL5Cjaa7xmwzAAUnUiy12uYaasbvJTuCArx2sdyuGAt90
 GfJyUwrfXaP/e/DAyqXArw0U39x9LB7K929m/xrjn7cvVoWXVVo5oN038IFpWjP+LlQE6wnvL
 oIKNuLHMzY9agVltAeWr+9a6I85A+VCuq98fPS+mX28J9hifXYFN3CewDmvDo22+rP1SZo4Be
 GJn0tZ7v8LDJRXYPmy77WQr9kbz5nfJaDnEnxNyIFQRqgreBRV9XuvQ/Xh48Zv/sBdQ+2oPom
 yxtmvCU64GebokgJcCZVcIwg/hXYOnDpP5AlmdRaSAwp0aZ7NFxjkG3IaR7gm7B7ShMI+NVxr
 Fyo1zLiqIFN2Jh5XWWF1CvxouAcNkKA9+/FdRNgdzk2HRelHt8JzqzTA46UJiCT4BebCwc6DZ
 cSj5xFslws4wfC+UDQswGgUb/gmI8Yo77njzvVtPAPALShjmhHr6vRaWYXLIzJjQbT1Y7hq5e
 oGVnXkP1w/WBzs+XZi6TDuWUpS6UigsMEEFxTzUbSxFj84S6DdEyFpqS40f9jFRSkmBR/swiF
 n5vl3TqxaaGSbZhPEWgXYVkMXLgumN2dd8o/3ywu+nvEvoeDs7BKXazwG2nU1yQGO/4QXPIlr
 +/8F9ezO6ya1N+KcUl7WJoqupja2B2aI3PLBIqRLkY3FT511M5iujUdDiNn0o+o4NYyd1g49/
 dwxoWZJs+z4cspk2qnSA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for you suggestion. I agree that it is nicer to reuse the cleanup in
iio_map_array_unregister() than to reimplement it. However I would like to
avoid dropping and regaining the mutex in case of error.
What about the attached approach:

Introduce an unlocked version of iio_map_array_unregister() and then use
this one to unwind in error case. Thus we only need to add two lines of
code, so that Jonathan may be ok with adding it to the main code flow...

Regards,
Lino

