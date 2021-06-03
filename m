Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6488339AA92
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCTAD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 15:00:03 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:42810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229620AbhFCTAD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jun 2021 15:00:03 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A3C66181D3043;
        Thu,  3 Jun 2021 18:58:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 72A13255108;
        Thu,  3 Jun 2021 18:58:16 +0000 (UTC)
Message-ID: <9499203f1e993872b384aabdec59ac223a8ab931.camel@perches.com>
Subject: General kernel misuse of vsnprintf SPECIAL %#<foo> (was: Re: [PATCH
 v2 0/4] iio: Drop use of %hhx and %hx format strings)
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Jun 2021 11:58:15 -0700
In-Reply-To: <20210603180612.3635250-1-jic23@kernel.org>
References: <20210603180612.3635250-1-jic23@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 72A13255108
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 313qdhu7rq3cd3o9yjo7a7mfhm7r5zwz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/U5V365+iUHUiPEgFbzw14eYA9Pmn8Flg=
X-HE-Tag: 1622746696-625043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2021-06-03 at 19:06 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A wrong use of one of these in
> https://lore.kernel.org/linux-iio/20210514135927.2926482-1-arnd@kernel.org/
> included a reference from Nathan to a patch discouraging the use of
> these strings in general:
> https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> 
> I did a quick grep and established we only have a few instances of these in
> IIO anyway, so in the interests of avoiding those existing cases getting
> cut and paste into new drivers, let's just clear them out now.
> 
> Note that patch from Arnd is now also part of this series, due to the
> length specifier related issue Joe raised.
> 
> I have chosen to go with 0x%02x rather than %#04x as I find it more readable.
> 
> V2:
> Use 0x%02x (Joe Perches)
> Include Arnd's original patch, modified for the above.

Hello again.

It looks to me as though %#<foo> is relatively commonly misused in the kernel.

Pehaps for the decimal portion of the format, checkpatch could have some
test for use of non-standard lengths.

Given the use is generally meant for a u8, u16, u32, or u64, perhaps
checkpatch should emit a warning whenever the length is not 4, 6, 10, or 18.

(possible checkpatch patch below)

$ git grep -P -h -o '%#\d+\w+' | sort | uniq -c | sort -rn
    392 %#08x
    238 %#04x
    144 %#02x
    114 %#06x
     92 %#010x
     58 %#010Lx
     55 %#018llx
     47 %#010llx
     45 %#010lx
     38 %#016llx
     27 %#0x
     23 %#2x
     18 %#016lx
     17 %#3lx
     17 %#08lx
     17 %#018Lx
     15 %#3x
     14 %#03x
     10 %#06hx
      9 %#08zx
      8 %#10x
      7 %#16llx
      6 %#8x
      6 %#04X
      6 %#04llx
      6 %#012llx
      5 %#16
      4 %#08llx
      4 %#06llx
      4 %#05x
      4 %#02X
      4 %#016Lx
      3 %#04hx
      3 %#01x
      2 %#6x
      2 %#4x
      2 %#10
      2 %#09x
      2 %#05lx
      1 %#8lx
      1 %#5x
      1 %#5lx
      1 %#2Lx
      1 %#2llx
      1 %#16x
      1 %#16lx
      1 %#12x
      1 %#0x10000
      1 %#0lx
      1 %#08
      1 %#05llx
      1 %#04o
      1 %#04lx
      1 %#03X
      1 %#018lx
      1 %#010zx

---
 scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d65334588eb4c..5840f3f2aee6f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6695,6 +6695,31 @@ sub process {
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
 
+				while ($fmt =~ /\%#([\d]+)/g) {
+					my $length = $1;
+					my $pref_len;
+					if ($length < 4) {
+						$pref_len = '04';
+					} elsif ($length == 5) {
+						$pref_len = '06';
+					} elsif ($length > 6 && $length < 10) {
+						$pref_len = '010';
+					} elsif ($length > 10 && $length < 18) {
+						$pref_len = '018';
+					} elsif ($length > 18) {
+						$pref_len = '<something else>';
+					}
+					if (defined($pref_len)) {
+						if (!defined($stat_real)) {
+							$stat_real = get_stat_real($linenr, $lc);
+						}
+						WARN("VSPRINTF_SPECIAL_LENGTH",
+						     "Unusual special length '%#$length' in 0x prefixed output, length is usually 2 more than the desired width - perhaps use '%#${pref_len}'\n" . "$here\n$stat_real");
+					}
+				}
+
+				pos($fmt) = 0;
+
 				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
 					$specifier = $1;
 					$extension = $2;

