Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6A28A925
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgJKSGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 14:06:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:59555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgJKSGS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 14:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602439559;
        bh=YC5jGh574QwPJER9OdCZ7nO/arw8Rn+20nQE4hLYKfk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lipZtGOxj4DdfQAfUDlu/uqJ4sd6z+WA40lUoVDlht+wCcsQcbM6tAGboFJzn947M
         mUgOdCRbV42/etjwAnGPkcPPceyo0Y8V3ttXcg0vgik0VfHjzBlgH9SY9xUZqGG5S6
         Y4B0pj/HHCoMiVHo4ILIWlGnLaqOC+Slh46U/xHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1kQ8l646jW-0185DN; Sun, 11
 Oct 2020 20:05:59 +0200
Subject: Re: [PATCH] iio:core: In map_array_register() cleanup in case of
 error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1602420080-15905-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201011160748.4a47b889@archlinux>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <6659ed59-306d-755d-6481-a4029eac5329@gmx.de>
Date:   Sun, 11 Oct 2020 20:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201011160748.4a47b889@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XZy3/luRrNsjGOhlINHhT3mQd7/PKF5YBnNJqbTuFpMYq5z4K8
 UbKzUqBCrO7/AciYtR0/uJEDB66yxHAqDA/NP9BeWdxctYyjYrrUv8a0j0ejMZsxuCm3nvx
 4haW0EFNrEsC0+GncIFmzFdiHAtEwxyxIJA2XQgemmF3ll1XWk/Ycf0mguRIXRqX/kRe6qf
 4TjahdrVyYAmb1bgdI3fQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CUlMnqXdupY=:JGvYw1RmnQ8CZEUT/TLF5T
 VgkKcqaJmYvzvIrjbX+N4blkZrwBXurwUf3ZuiOF38mOendoH+ki2k7hD4GoCQ3SY1p0+tWs4
 6sGhxp43DT1YTWDHJoY03ec0j6fMecVLmwMeSdOJqe+vyyc0MFp88avXkLoAfdRJ6MPUhmVpw
 pxFqtDlxexnPLDAQ9ZryZNRVy98ByfPY8UqOhR9n6bjChFzq/dZSYLsVKw97W2NIkRtp91Y0r
 c3bolBl+6Y05Ph+Bf4sY+xl9Wm49VW+4L6ZtRSivwbypXJM1k2HO/iN04LNQiGEyLEaYeNJwy
 56ZGvtxYwEnv7sreOtNg15d6jhRzKIRFLoqQlnpfZVa7MWYNnxi0XjLcS/nJWAf9rmk3RBhZ1
 mXDknYTDsYs5eXiB70upB8dI6QfQ3N/jLbnWzXwL618C5VIia8+gXw3MHgQy1RKsS4Jo5oD/V
 UG4IjxFhi6IQsD9cUCaZKcOvx3g4aZCsoa+Gu1J94EpF55i3/NQQCthl9Fz3xX7zYtoypBSg7
 3exQh+Xz/QdsSHAUq7r7DU0+FZ44BRog0dEvNvCwCyndM4Y5EO/d5Mw3D1zoexASGYhdT70Fw
 vE6w0aDym7q5Q+Gd3wXMHJ3KcfQBRGriPB9+q6jNxFGuFi6QHJcPZQ+tf4k1FhF0I83RPaaKe
 L9R3a+iCr88kvY2vsCLSvF2uV0073pPWw5DfhQAkaHrpoCdvo9706OQndApSPeJDlxeBDjbO9
 LGjq4mKbGPJEIK8dqYySA5mIhGxkJfT1BlPzF/9o8fkOTXhcZ/vmRCjdVrNakdg2bXj3V6D5K
 Vf1IqcQDd0o0WlyIyTCaPZgXtVYshlYqYhhMTrK0GMd1zl3oKDgGs7PLbHvtUGWrm4N4l0liC
 RRFtsmGhOajKNJ6mJOlRRi14GEv1MMoUqeNxIrJnKoMOQgn/lr0oOYIF5Mk1FqD0NiaD3gFNT
 OxF0mF7B4Ep0cocEsS8rGuRXBtKC1/gD7k6mojbB+4+TiCRaDMFYm3hgWb0bbE0fgR50j75+I
 CHf0uhpJVMiw100tfbJeZKQJUxQRtayFo/bbG/nIZastsDBpTa0ukU8GeW5hg2/QQ0wpovMST
 PIRHGnT3onVPOGFSjfW1azSvGjS/dJS3UfO31FOW289mCtDnrrBwKhePlVbkpdgQt6/CCuhMg
 16+4XBFNSUmJiHNQCYfNfMONq2i5FqFRE1nGhQtBLiFCJNk+oFDu8vT9ERStIcC6q0eentoa0
 YVLzlAxGhrJosiLwZa7jqc/eeiFtyHXNSNwZh1Q==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Am 11.10.20 um 17:07 schrieb Jonathan Cameron:
>
> Good spot. I'd rather we went with a different code flow though.
> See below.
>

Ok, will adjust the code and send a V2 shortly.

Regards,
Lino
